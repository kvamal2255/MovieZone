//
//  APIManager.swift
//  MovieZone
//
//  Created by Amal K V on 9/4/25.
//

import Foundation

private let statusType: String = "type"
private let errorTitle: String = "title"
private let apiErrorMessageKey: String = "message"

public protocol NetworkerProtocol: AnyObject {
    typealias Headers = [String: Any]
    /// GET
    func get<T>(type: T.Type,
                url: URL, headers: Headers) async -> Result<T, NetworkError> where T: Decodable
    
    /// POST
    func post<T>(type: T.Type, url: URL, headers: Headers, postData: [String: Any]) async -> Result<T, NetworkError> where T: Decodable
    
    /// PUT
    func put<T>(type: T.Type, url: URL, headers: Headers, postData: [String: Any]) async -> Result<T, NetworkError> where T: Decodable
        
}

// This is Networker wrapper class to access all 'API' service. Here we have to conform 'NetworkerProtocol' to access all methods GET, POST, PUT
public class APIManager: NetworkerProtocol {
    
    public static let shared = APIManager()
    
    private init() {}
    
    private func getUrlRequest(url: URL, headers: Headers, httpMethod: HTTPMethod) -> URLRequest {
        
        var urlRequest = URLRequest(url: url)
        // Set Method name
        urlRequest.httpMethod = httpMethod.rawValue
        // Add header value to url request
        headers.forEach { key, value in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        addAppInfoInHeader(&urlRequest)
        return urlRequest
    }
    
    /// Get Method
    /// - Returns: Return Decodable type(which will return given model)
    public  func get<T>(type: T.Type,
                        url: URL, headers: Headers) async -> Result<T, NetworkError> where T: Decodable {
        let urlRequest = getUrlRequest(url: url, headers: headers, httpMethod: .GET)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noresponse(getError("Error", "No Response")))
            }
            return getResultFromResponse(type: type, response: response, data: data)
        } catch {
            return .failure(NetworkError.unknownError(APIError(title: "Error", message: error.localizedDescription)))
        }
        
    }
    
    /// Post Method
    /// - Returns: Return Decodable type(which will return given model)
    public func post<T>(type: T.Type, url: URL, headers: Headers, postData: [String: Any] = [:]) async -> Result<T, NetworkError> where T: Decodable {
        
        var urlRequest = getUrlRequest(url: url, headers: headers, httpMethod: .POST)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if !postData.isEmpty {
            let jsonData = try? JSONSerialization.data(withJSONObject: postData)
            urlRequest.httpBody = jsonData
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noresponse(getError("Error", "No Response")))
            }
            return getResultFromResponse(type: type, response: response, data: data)
        } catch {
            return .failure(NetworkError.unknownError(APIError(title: "Error", message: error.localizedDescription)))
        }
    }
    
    /// Put Method
    /// - Returns: Return Decodable type(which will return given model)
    public func put<T>(type: T.Type, url: URL, headers: Headers, postData: [String: Any] = [:]) async -> Result<T, NetworkError> where T: Decodable {
        
        var urlRequest = getUrlRequest(url: url, headers: headers, httpMethod: .PUT)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if !postData.isEmpty {
            let jsonData = try? JSONSerialization.data(withJSONObject: postData)
            urlRequest.httpBody = jsonData
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noresponse(getError("Error", "No Response")))
            }
            return getResultFromResponse(type: type, response: response, data: data)
        } catch {
            return .failure(NetworkError.unknownError(APIError(title: "Error", message: error.localizedDescription)))
        }
    }
}

/// Success will return the given Decoder Data type, Failure will return the NetworkError
private func getResultFromResponse<T>(type: T.Type, response: HTTPURLResponse, data: Data) -> Result<T, NetworkError> where T: Decodable {
    
    switch response.statusCode {
    case 200...299:
        do {
            let decodedResponse = try JSONDecoder().decode(type, from: data)
            return .success(decodedResponse)
        } catch {
            debugPrint("\(error)")
            return .failure(NetworkError.decodeError(getError("Error response", error.localizedDescription)))
        }
    default:
        return .failure(getErrorResponse(response: response, data: data))
    }
}

private func getErrorResponse(response: HTTPURLResponse, data: Data) -> NetworkError {
    switch response.statusCode {
    case 401:
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                let data = APIError(title: json[errorTitle] as? String ?? "Error", message: json[apiErrorMessageKey] as? String ?? "Something went wrong. Please try again", data: json)
                return NetworkError.unauthorized(data)
            } else {
                return NetworkError.unauthorized(getError("Error", "Unauthorized access"))
            }
        } catch {
            return NetworkError.unknownError(unknownError())
        }
    case 498:
        return NetworkError.sessionExpired(getError("Error", "Authentication Token Expired"))
    default:
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                let data = APIError(title: json[errorTitle] as? String ?? "Error", message: json[apiErrorMessageKey] as? String ?? "Something went wrong. Please try again", data: json, responseCode: response.statusCode)
                debugPrint("API Error - \(json)")
                return NetworkError.apiError(data)
            } else {
                return NetworkError.unknownError(unknownError())
            }
        } catch {
            return NetworkError.unknownError(unknownError())
        }
    }
}

fileprivate func addAppInfoInHeader(_ urlRequest: inout URLRequest) {
    urlRequest.setValue("e3dffa7397mshfa4846606754970p102e83jsn4fe1627e7605", forHTTPHeaderField: "X-RapidAPI-Key")
    urlRequest.setValue("imdb236.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
}
