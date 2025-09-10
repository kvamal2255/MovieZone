//
//  MovieDetailUIViewModel.swift
//  MovieZone
//
//  Created by Amal K V on 9/9/25.
//

import Foundation

public struct MovieDetailUIViewModel {
    public var id: String = ""
    public var title: String = ""
    public var imageUrl: String?
    public var description: String = ""
    public var year: String = ""
    public var genres: [String] = []
    public var productionCompanies: [String] = []
    public var runtime: String = ""
    public var rating: String = ""
    public var director: String = ""
    public var castList: [MovieCastUIViewModel] = []
    
    public init(movieData: MovieDetailData) {
        self.id = movieData.id ?? ""
        self.title = movieData.title ?? ""
        self.imageUrl = movieData.primaryImage
        self.description = movieData.description ?? ""
        self.year = formatDate(date: movieData.releaseDate ?? "")
        self.genres = movieData.genres ?? []
        if let productionCompanies = movieData.productionCompanies, !productionCompanies.isEmpty  {
            self.productionCompanies = productionCompanies.map({$0.name ?? ""})
        }
        self.runtime = formatRuntime(minutes: movieData.runtimeMinutes ?? 0)
        if let rating = movieData.averageRating {
            self.rating = "\(rating)"
        }
        self.director = movieData.directors?.first?.fullName ?? "NA"
        self.castList = movieData.cast?.compactMap({MovieCastUIViewModel(data: $0)}) ?? []
    }
    
    public init(movieDetailTB: MovieDetailTB) {
        self.id = movieDetailTB.id
        self.title = movieDetailTB.title
        self.imageUrl = movieDetailTB.imageUrl
        self.description = movieDetailTB.detail ?? ""
        self.year = String(describing: movieDetailTB.year)
    }
    
    public var productionCompaniesDescription: String {
        return productionCompanies.joined(separator: ", ")
    }
}

public struct MovieCastUIViewModel {
    var id: String = ""
    var name: String = ""
    var url: String?
    
    public init(data: MovieCastData) {
        self.id = data.id ?? ""
        self.name = data.fullName ?? "NA"
        self.url = data.thumbnails?.first?.url
    }
}
