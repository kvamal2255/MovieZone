//
//  FavoriteListView.swift
//  MovieZone
//
//  Created by Amal K V on 9/4/25.
//

import SwiftUI

struct FavoriteListView: View {
    
    @StateObject private var viewModel = FavoriteListViewModel()
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            if viewModel.favoriteMovies.isEmpty {
                emptyStateView()
            } else {
                getMovieCards()
            }
        }
        .navigationTitle("My Favorites")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    fileprivate var gridItemLayout: [GridItem] {
        return Array(repeating: .init(.flexible(), spacing: 16, alignment: .top), count: 2)
    }
    
    private func getMovieCards() -> some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: gridItemLayout, spacing: 16) {
                ForEach(viewModel.favoriteMovies, id: \.id) { movie in
                    NavigationLink {
                        MovieDetailView(movie: movie)
                            .onDisappear {
                                viewModel.fetchFavorites()
                            }
                    } label: {
                        MovieCardView(movie: movie)
                    }
                }
            }
            .padding(.vertical)
            .padding(.horizontal, .large)
        }
    }
    
    @ViewBuilder
    private func emptyStateView() -> some View {
        EmptyState(
            title: "No Favorites Yet",
            description: "Your favorite items will appear here. Start adding some to see them in your list.") {
            }
    }
}

#Preview {
    FavoriteListView()
}
