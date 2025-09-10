//
//  FavoriteListViewModel.swift
//  MovieZone
//
//  Created by Amal K V on 9/10/25.
//

import Foundation

class FavoriteListViewModel: ObservableObject {
    
    @Published var favoriteMovies: [MovieListUIViewModel] = []
    
    public init() {
        fetchFavorites()
    }
    
    public func fetchFavorites() {
        if let favoriteMoviesDB = DatabaseManager.shared.fetchObjects(MovieDetailTB.self) as? [MovieDetailTB] {
            let favoriteMovies = favoriteMoviesDB.compactMap { movieTB in
                MovieListUIViewModel(movieDetailTB: movieTB)
            }
            DispatchQueue.main.async { [weak self] in
                self?.favoriteMovies = favoriteMovies
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.favoriteMovies = []
            }
        }
    }
}
