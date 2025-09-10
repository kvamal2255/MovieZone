//
//  NetworkError.swift
//  MovieZone
//
//  Created by Amal K V on 9/4/25.
//

import Foundation

/// `NetworkError`
///
/// Types of possible erro's which will retrun from URL Session
public enum NetworkError: Error {
    
    case noresponse(APIError)
    case invalidData(APIError)
    case unauthorized(APIError)
    case decodeError(APIError)
    case apiError(APIError)
    case unknownError(APIError)
    case noInternet(APIError)
    case sessionExpired(APIError)
}

/// Getting `APIError` by passing error title and message
/// - Parameters:
///   - title: Error Title
///   - message: Error Message
/// - Returns: which will returns as `APIError`
public func getError(_ title: String, _ message: String) -> APIError {
    return APIError(title: title, message: message)
}

public func unknownError() -> APIError {
    return APIError(title: "Error", message: "Unknown error")
}

/// Custom `APIError`
///
/// This struct is used to show custom error which is throw from backend side.
public struct APIError {
    public let title: String
    public let message: String
    public let data: [String: AnyObject]?
    public let responseCode: Int?
    
    public init(title: String, message: String, data: [String: AnyObject]? = nil, responseCode: Int? = nil) {
        self.title = title
        self.message = message
        self.data = data
        self.responseCode = responseCode
    }
}

/// Get APIError by passing `NetworkError`
/// - Parameter error: Types of error `NetworkError`
/// - Returns: which will returns as `APIError`
public func getErrorFromNetworkError(_ error: NetworkError) -> APIError {
    switch error {
        
    case .invalidData(let invalidError):
        return invalidError
        
    case .noresponse(let noResponseError):
        return noResponseError
        
    case .unauthorized(let unauthorizedError):
        return unauthorizedError
        
    case .decodeError(let decodeError):
        return decodeError
        
    case .apiError(let apiError):
        return apiError
        
    case .unknownError(let unknownError):
        return unknownError
        
    case .noInternet(_):
        return APIError(title: "Offline", message: "You are not connected to the internet. Please check your connection and try again.")
        
    case .sessionExpired(_):
        return APIError(title: "Session Expired", message: "Authentication Token Expired")
    }
}
