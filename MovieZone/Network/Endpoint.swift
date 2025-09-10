//
//  Endpoint.swift
//  MovieZone
//
//  Created by Amal K V on 9/4/25.
//

import Foundation

/// Endpoint to define all  API path to communicate server
public struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []

    public init(path: String, queryItems: [URLQueryItem] = []) {
        self.path = path
        self.queryItems = queryItems
    }
}
