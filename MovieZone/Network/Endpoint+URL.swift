//
//  Endpoint+URL.swift
//  MovieZone
//
//  Created by Amal K V on 9/4/25.
//

import Foundation

/// HTTP methods
public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
}

extension Endpoint {
    public var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "imdb236.p.rapidapi.com"
        components.path = "/api/imdb" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            debugPrint("Application - Invalid URL components: \(components)")
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
}


public func getAppUrl() -> URL? {
    return URL(string: "https://imdb236.p.rapidapi.com")
}
