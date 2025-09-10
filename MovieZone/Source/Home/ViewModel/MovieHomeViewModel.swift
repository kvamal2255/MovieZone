//
//  MovieHomeViewModel.swift
//  MovieZone
//
//  Created by Amal K V on 9/4/25.
//

import Foundation

class MovieHomeViewModel: ObservableObject {
    
    @Published var loadingState: LoadingState = .idle
    @Published var movieList: [MovieListUIViewModel] = []
    @Published var favMoviesCount: String = "0"
    
    // MARK: - Internal Variables
    var movieService: MovieDBRepository
    
    // MARK: - initialization
    public init(movieService: MovieDBRepository = MovieRepository()) {
        self.movieService = movieService
        reload()
    }
    
    
    func reload() {
        Task {
            await fetchMovieList()
        }
    }
    
    func fetchMovieList() async {
        await MainActor.run {
            loadingState = .loading
        }
        let result = await movieService.getMovieList()
        switch result {
        case .success(let movies):
            let movieList = movies.map {
                MovieListUIViewModel(movieData: $0)
            }
            await MainActor.run {
                self.movieList = movieList
                loadingState = .loaded
            }
        case .failure(let error):
            let networkError = getErrorFromNetworkError(error)
            debugPrint("error is: \(networkError.message)")
            await MainActor.run {
                loadingState = .failed(.init(title: networkError.title, message: networkError.message))
            }
        }
    }
    
    @MainActor
    /// Fetches the count of favorite movies from the database and updates the published property
    func fetchFavoriteMoviesCount() {
        if let favoriteMovies = DatabaseManager.shared.fetchObjects(MovieDetailTB.self) {
            let count = favoriteMovies.count
            self.favMoviesCount = "\(count)"
        } else {
            self.favMoviesCount = "0"
        }
    }
}
