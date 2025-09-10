//
//  MovieDetail+Database.swift
//  MovieZone
//
//  Created by Amal K V on 9/9/25.
//

import Foundation
import Realm
import RealmSwift

func removeMovieFromDatabase(movie: MovieDetailTB) {
    do {
        let realm = try Realm()
        try realm.write {
            realm.delete(movie)
        }
    } catch {
        debugPrint("Error deleting favorite: \(error)")
    }
}

func saveMovieToDatabase(movie: MovieDetailTB) {
    DatabaseManager.shared.saveObject(movie)
}
