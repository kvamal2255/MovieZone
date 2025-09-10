//
//  MovieListUIViewModel.swift
//  MovieZone
//
//  Created by Amal K V on 9/4/25.
//

import Foundation

struct MovieListUIViewModel {
    var id: String = ""
    var title: String = ""
    var imageUrl: String?
    var description: String = ""
    var year: String = ""
    var rating: String = "0.0"
    
    public init(movieData: MovieDetailData) {
        self.id = movieData.id ?? ""
        self.title = movieData.title ?? ""
        self.imageUrl = movieData.imageDetail?.first?.url
        self.description = movieData.description ?? ""
        self.year = formatDate(date: movieData.releaseDate ?? "")
        if let rating = movieData.averageRating {
            self.rating = "\(rating)"
        }
    }
    
    public init(movieDetailTB: MovieDetailTB) {
        self.id = movieDetailTB.id
        self.title = movieDetailTB.title
        self.imageUrl = movieDetailTB.imageUrl
        self.description = movieDetailTB.detail ?? ""
        self.year = String(describing: movieDetailTB.year)
        self.rating = movieDetailTB.rating ?? "0.0"
    }
}
