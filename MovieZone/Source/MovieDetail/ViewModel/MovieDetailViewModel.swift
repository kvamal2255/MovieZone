//
//  MovieDetailViewModel.swift
//  MovieZone
//
//  Created by Amal K V on 9/7/25.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    
    // MARK: Normal Variable
    var movie: MovieListUIViewModel
    var movieService: MovieDBRepository
    
    // MARK: Published
    @Published var loadingState: LoadingState = .idle
    @Published var movieDetail: MovieDetailUIViewModel?
    @Published var isFavorited: Bool = false
    
    // MARK: init
    public init (movie: MovieListUIViewModel, movieService: MovieDBRepository = MovieRepository()) {
        self.movie = movie
        self.movieService = movieService
        reload()
    }
    
    func reload() {
        Task {
            await fetchMovieDetail()
        }
    }
    
    func fetchMovieDetail() async {
        await MainActor.run {
            loadingState = .loading
        }
        let result = await movieService.getMovieDetail(uid: movie.id)
        switch result {
        case .success(let movie):
            await MainActor.run {
                self.movieDetail = MovieDetailUIViewModel(movieData: movie)
                loadingState = .loaded
                // Check if favorited after loading the movie details
                Task {
                    await self.checkIfFavorited()
                }
            }
        case .failure(let error):
            let networkError = getErrorFromNetworkError(error)
            debugPrint("error is: \(networkError.message)")
            await MainActor.run {
                loadingState = .failed(.init(title: networkError.title, message: networkError.message))
            }
        }
    }
}

// MARK: DataBase helpers
extension MovieDetailViewModel {
    func checkIfFavorited() async {
        guard let movieDetail = self.movieDetail else { return }
        
        await MainActor.run { [weak self] in
            guard let self = self else { return }
            
            let predicate = NSPredicate(format: "id == %@", movieDetail.id)
            if let favorites = DatabaseManager.shared.fetchObjects(MovieDetailTB.self, predicate: predicate),
               !favorites.isEmpty {
                self.isFavorited = true
            } else {
                self.isFavorited = false
            }
        }
    }
       
    @MainActor
    func toggleFavorite() async {
        guard let movieDetail = self.movieDetail else { return }
        
        if isFavorited {
            // Remove from favorites
            if let favoriteMoviesDB = DatabaseManager.shared.fetchObjects(MovieDetailTB.self) as? [MovieDetailTB] {
                // Find the movie to delete
                if let movieToDelete = favoriteMoviesDB.first(where: { $0.id == movieDetail.id }) {
                    self.isFavorited = false
                    removeMovieFromDatabase(movie: movieToDelete)
                }
            }
        } else {
            // Add to favorites
            let movieTB = MovieDetailTB(movieDetail: movieDetail)
            // Save on the same thread
            saveMovieToDatabase(movie: movieTB)
            self.isFavorited = true
        }
    }
}
