//
//  MovieService.swift
//  MovieZone
//
//  Created by Amal K V on 9/4/25.
//

import Foundation

public protocol MovieServiceDataSource: AnyObject {
    func getMovieList() async -> Result<[MovieDetailData], NetworkError>
    func getMovieDetail(uid: String) async -> Result<MovieDetailData, NetworkError>
    func getMovieList(with searchText: String) async -> Result<[MovieDetailData], NetworkError>
}

public class MovieService: MovieServiceDataSource {
    
    public var networker: NetworkerProtocol
    
    public init(networker: NetworkerProtocol = APIManager.shared) {
        self.networker = networker
    }
    
    public func getMovieList() async -> Result<[MovieDetailData], NetworkError> {
        let endpoint = Endpoint.movieList()
        return await networker.get(type: [MovieDetailData].self, url: endpoint.url, headers: [ : ])
    }
    
    public func getMovieDetail(uid: String) async -> Result<MovieDetailData, NetworkError> {
        let endpoint = Endpoint.movieDetail(uid: uid)
        return await networker.get(type: MovieDetailData.self, url: endpoint.url, headers: [ : ])
    }
    
    public func getMovieList(with searchText: String) async -> Result<[MovieDetailData], NetworkError> {
        let endpoint = Endpoint.movieList(with: searchText)
        return await networker.get(type: [MovieDetailData].self, url: endpoint.url, headers: [ : ])
    }
}
