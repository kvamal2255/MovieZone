//
//  MovieSearchViewModel.swift
//  MovieZone
//
//  Created by Amal K V on 9/10/25.
//

import Foundation
import Combine

class MovieSearchViewModel: ObservableObject {
    
    @Published var loadingState: LoadingState = .idle
    @Published var movieList: [MovieListUIViewModel] = []
    @Published public var searchText: String = ""
    
    var movieService: MovieDBRepository
    var cancellable: AnyCancellable?
    
    // Search
    private var searchTask: Task<Void, Never>?
    
    init (movieService: MovieDBRepository = MovieRepository()) {
        self.movieService = movieService
        addSubscriberToSearch()
    }
    
    deinit {
        cancellable?.cancel()
        searchTask?.cancel()
    }
    
    public func addSubscriberToSearch() {
        cancellable = $searchText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                guard let self else { return }
                // Cancel any existing search task
                self.searchTask?.cancel()
                self.searchTask = Task { @MainActor in
                    
                    guard !Task.isCancelled else { return }
                    
                    self.perfromSearch()
                    
                }
            }
    }
    
    func perfromSearch() {
        Task {
            await fetchMovieList()
        }
    }
    
    @MainActor
    private func resetSearch() {
        self.movieList = []
        self.loadingState = .idle
    }
    
    func fetchMovieList() async {
        guard !searchText.isEmpty else {
            await resetSearch()
            return
        }
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
}
