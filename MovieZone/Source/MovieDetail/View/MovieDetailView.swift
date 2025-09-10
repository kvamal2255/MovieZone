//
//  MovieDetailView.swift
//  MovieZone
//
//  Created by Amal K V on 9/7/25.
//

import SwiftUI

struct MovieDetailView: View {
    
    // MARK: Environment
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @StateObject var viewModel: MovieDetailViewModel
    
    public init(movie: MovieListUIViewModel) {
        self._viewModel = StateObject(wrappedValue: .init(movie: movie))
    }
    
    var body: some View {
        mainContentView
            .navigationTitle(viewModel.movie.title)
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private var mainContentView: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            switch viewModel.loadingState {
            case .idle:
                EmptyView()
            case .loading:
                ShimmerView(shimmerType: .movieDetail)
            case .failed(let customError):
                errorStateView(error: customError)
            case .loaded:
                conetntView
            case .noInternet:
                networkUnavailable
            case .emptyState:
                EmptyView()
            }
        }
    }
    
    private var conetntView: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: .medium) {
                movieHeaderView
                narrativeView
                castListView
                genresView
                productionCompaniesView
            }
            .padding(.horizontal, .xMedium)
        }
    }
    
    private var movieHeaderView: some View {
        
        HStack(alignment: .top, spacing: .large) {
            
            headerImageView
            
            VStack(alignment: .leading, spacing: .medium) {
                Text(viewModel.movieDetail?.title ?? "")
                    .font(.system(.title2, weight: .semibold))
                    .foregroundStyle(Color.black)
                    .lineLimit(2)
                
                VStack(alignment: .leading, spacing: .small) {
                    BasicInfoView(title: "Director", description: viewModel.movieDetail?.director ?? "")
                    
                    BasicInfoView(title: "Release Date", description: viewModel.movieDetail?.year ?? "")
                    
                    BasicInfoView(title: "Runtime", description: viewModel.movieDetail?.runtime ?? "")
                }
            }
        }
        .padding(.top, .small)
    }
    
    private var headerImageView: some View {
        
        ZStack(alignment: .topTrailing) {
            
            
            ZStack(alignment: .bottomLeading) {
                AsyncImageView(imageURLStr: viewModel.movieDetail?.imageUrl ?? "", imageWidth: (screenWidth / 2 ) - 20, imageHeight: padding(height: 300), contentMode: .fill)
                    .cornerRadius(12)
                
                HStack(spacing: .xSmall) {
                    Image(.icRatingStar)
                        .resizable()
                        .frame(width: .normal, height: .normal)
                    
                    Text(viewModel.movieDetail?.rating ?? "NA")
                        .font(.subheadline)
                        .foregroundColor(.yellow)
                }
                .padding(.leading, .small)
                .padding(.bottom, .normal)
                
            }
            
            FavIconView(isSelected: viewModel.isFavorited) {
                Task {
                    await viewModel.toggleFavorite()
                }
            }
            .padding(.top, .normal)
            .padding(.trailing, .small)
        }
    }
}

extension MovieDetailView {
    @ViewBuilder
    private var genresView: some View {
        if let genres = viewModel.movieDetail?.genres, !genres.isEmpty {
            VStack(alignment: .leading, spacing: 0) {
                Text("Genres")
                    .font(.system(.headline, weight: .medium))
                    .foregroundStyle(Color.black)
                    .padding(.bottom, .normal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: .xSmall) {
                        ForEach(genres, id: \.self) { genre in
                            Text(genre)
                                .foregroundStyle(Color.white)
                                .font(.system(size: 12, weight: .regular))
                                .padding(.horizontal)
                                .frame(height: 24)
                                .background(Color.red.opacity(0.8))
                                .cornerRadius(30 / 2)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var narrativeView: some View {
        BasicInfoView(title: "Synopsis", description: viewModel.movieDetail?.description ?? "", titleFont: .system(.headline, weight: .medium), spacing: .normal)
    }
    
    @ViewBuilder
    var productionCompaniesView: some View {
        BasicInfoView(title: "Production Companies", description: viewModel.movieDetail?.productionCompaniesDescription ?? "NA", titleFont: .system(.headline, weight: .medium), spacing: .normal)
    }
    
    private var castListView: some View {
        MovieCastCollectionView(castList: viewModel.movieDetail?.castList ?? [])
    }
}

// MARK: Error Cases
extension MovieDetailView {
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
}

// MARK: - Dynamic Padding Calculation
extension MovieDetailView {
    private func padding(height: CGFloat) -> CGFloat {
        (screenHeight - (safeAreaInsets.top + safeAreaInsets.bottom)) * (height / 864.51)
    }
    
    private func padding(width: CGFloat) -> CGFloat {
        (screenWidth) * (width / 390)
    }
}
