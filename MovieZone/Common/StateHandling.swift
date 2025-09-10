//
//  StateHandling.swift
//  MovieZone
//
//  Created by Amal K V on 9/7/25.
//

import Foundation

public enum LoadingState {
    case idle
    case loading
    case failed(CustomError)
    case loaded
    case noInternet
    case emptyState
    
}

public struct CustomError {
    public let title: String
    public let message: String
    
    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}
