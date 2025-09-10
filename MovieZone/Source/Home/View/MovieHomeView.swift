//
//  MoviewHomeView.swift
//  MovieZone
//
//  Created by Amal K V on 9/4/25.
//

import SwiftUI

struct MovieHomeView: View {
    
    @StateObject private var viewModel = MovieHomeViewModel()
    
    var body: some View {
        NavigationView {
            contentView
        }
    }
    
    private var contentView: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            connectionStateView
        }
        .navigationTitle("All Movies")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                favorateIcon
            }
        }
        .onAppear {
            viewModel.fetchFavoriteMoviesCount()
        }
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
            emptyStateView()
        }
    }
    
    private var searchBar: some View {
        NavigationLink {
            MovieSearchView()
        } label: {
            GlobalSearchbarView(text: .constant(""), hideCancel: true, showCloseButton: true)
                .listModifier()
                .disabled(true)
        }
        .padding(.horizontal, .medium)
    }
    
    private var favorateIcon: some View {
        NavigationLink {
            FavoriteListView()
        } label: {
            Image(.icHeartEmpty)
                .resizable()
                .frame(width: 25, height: 25)
                .overlay(alignment: .topTrailing) {
                    unreadBadgeView(count: viewModel.favMoviesCount)
                }
        }
    }
    
    private var listView: some View {
        VStack(spacing: .small) {
            searchBar
            getMovieCards()
        }
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
    
    @ViewBuilder
    private func unreadBadgeView(count: String) -> some View {
        if count != "0" {
            Text(count)
                .foregroundStyle(Color.white)
                .lineLimit(1)
                .padding(3)
                .frame(height: 20)
                .frame(minWidth: 15, maxWidth: 25)
                .fixedSize(horizontal: false, vertical: true)
                .scaledToFill()
                .minimumScaleFactor(0.6)
                .background(Color.red)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(x: 12, y: -10)
        }
    }
    
    @ViewBuilder
    private func errorStateView(error: CustomError) -> some View {
        EmptyState(
            title: error.title,
            description: error.message) {
                viewModel.reload()
            }
    }
    
    @ViewBuilder
    private var networkUnavailable: some View {
        NoInternetState {
            viewModel.reload()
        }
    }
    
    @ViewBuilder
    private func emptyStateView() -> some View {
        EmptyState(
            title: "No Moves Available",
            description: "You don’t have any moves in your list yet. Start adding moves to see them here.") {
                viewModel.reload()
            }
    }
}

#Preview {
    MovieHomeView()
}
