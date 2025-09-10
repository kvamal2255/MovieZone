//
//  MovieDBRepository.swift
//  MovieZone
//
//  Created by Amal K V on 9/4/25.
//

import Foundation

public protocol MovieDBRepository: AnyObject {
    
    func getMovieList() async -> Result<[MovieDetailData], NetworkError>
    func getMovieDetail(uid: String) async -> Result<MovieDetailData, NetworkError>
    func getMovieList(with searchText: String) async -> Result<[MovieDetailData], NetworkError>
}

public class MovieRepository: MovieDBRepository {
    
    var movieService: MovieService
    
    public init(movieService: MovieService = .init()) {
        self.movieService = movieService
    }
    
    public func getMovieList() async -> Result<[MovieDetailData], NetworkError> {
        return await movieService.getMovieList()
    }
    
    public func getMovieDetail(uid: String) async -> Result<MovieDetailData, NetworkError> {
        return await movieService.getMovieDetail(uid: uid)
    }
    
    public func getMovieList(with searchText: String) async -> Result<[MovieDetailData], NetworkError> {
        return await movieService.getMovieList(with: searchText)
    }
}
