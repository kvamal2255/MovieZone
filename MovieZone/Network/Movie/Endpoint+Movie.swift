//
//  Endpoint+Movie.swift
//  MovieZone
//
//  Created by Amal K V on 9/4/25.
//

import Foundation

extension Endpoint {
    
    static func movieList() -> Self {
         return Endpoint(path: "/most-popular-movies")
    }
    
    static func movieDetail(uid: String) -> Self {
        return Endpoint(path: "/\(uid)")
    }
    
    static func movieList(with searchText: String) -> Self {
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "primaryTitleAutocomplete", value: searchText),
            URLQueryItem(name: "type", value: "movie"),
            URLQueryItem(name: "rows", value: "25"),
            URLQueryItem(name: "sortOrder", value: "ASC"),
            URLQueryItem(name: "sortField", value: "id")
        ]
        return Endpoint(
            path: "/search",
            queryItems: queryItems
        )
    }
}
