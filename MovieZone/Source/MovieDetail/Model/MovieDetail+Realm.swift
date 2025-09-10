//
//  MovieDetail+Realm.swift
//  MovieZone
//
//  Created by Amal K V on 9/7/25.
//

import Foundation
import RealmSwift

public class MovieDetailTB: Object {
    @Persisted public var id: String
    @Persisted public var title: String
    @Persisted public var imageUrl: String?
    @Persisted public var detail: String?
    @Persisted public var year: String?
    @Persisted public var rating: String?

    required override init() {
        super.init()
    }
    
    public init(movieDetail: MovieDetailUIViewModel) {
        self.id = movieDetail.id
        self.title = movieDetail.title
        self.detail = movieDetail.description
        self.imageUrl = movieDetail.imageUrl
        self.year = movieDetail.year
        self.rating = movieDetail.rating
    }
}
