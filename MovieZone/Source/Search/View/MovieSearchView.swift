//
//  MovieSearchView.swift
//  MovieZone
//
//  Created by Amal K V on 9/10/25.
//

import SwiftUI

struct MovieSearchView: View {
    
    @StateObject private var viewModel = MovieSearchViewModel()
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack {
                searchBar
                connectionStateView
                Spacer(minLength: 0)
            }
        }
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private var connectionStateView: some View {
        switch viewModel.loadingState {
        case .idle:
            EmptyView()
        case .loading:
            ShimmerView(shimmerType: .movieGrid)
        case .failed(let customError):
            errorStateView(error: customError)
        case .loaded:
            listView
        case .noInternet:
            networkUnavailable
        case .emptyState:
            EmptyView()
        }
    }
    
    private var listView: some View {
        getMovieCards()
    }
    
    private var searchBar: some View {
        GlobalSearchbarView(text: $viewModel.searchText, placeholderText: "Search Movies", hideCancel: true, showCloseButton: true)
            .listModifier()
            .padding(.horizontal, .medium)
    }
    
    fileprivate var gridItemLayout: [GridItem] {
        return Array(repeating: .init(.flexible(), spacing: 16, alignment: .top), count: 2)
    }
    
    private func getMovieCards() -> some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: gridItemLayout, spacing: 16) {
                ForEach(viewModel.movieList, id: \.id) { movie in
                    NavigationLink {
                        MovieDetailView(movie: movie)
                    } label: {
                        MovieCardView(movie: movie)
                    }
                }
            }
            .padding(.vertical)
            .padding(.horizontal, .large)
        }
    }
}

extension MovieSearchView {
    @ViewBuilder
    private func errorStateView(error: CustomError) -> some View {
        EmptyState(
            title: "No Movies Found",
            description: "We couldn't find any movies matching your search. Please try a different keyword."
        ) {
            viewModel.perfromSearch()
        }
    }
    
    @ViewBuilder
    private var networkUnavailable: some View {
        NoInternetState {
            viewModel.perfromSearch()
        }
    }
}

#Preview {
    MovieSearchView()
}
