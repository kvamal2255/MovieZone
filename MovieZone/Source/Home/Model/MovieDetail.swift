//
//  MovieDetail.swift
//  MovieZone
//
//  Created by Amal K V on 9/4/25.
//

import Foundation

public struct MovieDetailData: Codable {
    let id: String?
    let title: String?
    let description: String?
    let imageDetail: [MovieThumbnailsData]?
    let releaseDate: String?
    let genres: [String]?
    let averageRating: Double?
    let runtimeMinutes: Int?
    let primaryImage: String?
    let productionCompanies: [ProductionComapanyData]?
    let directors: [MovieDirectorData]?
    let cast: [MovieCastData]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "primaryTitle"
        case description
        case imageDetail = "thumbnails"
        case releaseDate
        case genres
        case averageRating
        case runtimeMinutes
        case primaryImage
        case productionCompanies = "productionCompanies"
        case directors = "directors"
        case cast
    }
}

public struct ProductionComapanyData: Codable {
    let id: String?
    let name: String?
}

public struct MovieThumbnailsData: Codable {
    let url: String?
}

public struct MovieDirectorData: Codable {
    let id: String?
    let fullName: String?
}

public struct MovieCastData: Codable {
    let id: String?
    let fullName: String?
    let thumbnails: [MovieThumbnailsData]?
}
