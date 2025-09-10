//
//  DatabaseManager.swift
//  MovieZone
//
//  Created by Amal K V on 9/4/25.
//

import Foundation
import RealmSwift
import Realm

public protocol DatabaseManagerDataSource {
    
    func saveObjects<T>(_ objects: [T]) where T: Object
    func saveObject<T>(_ object: T) where T: Object
    
    func fetchObjects(_ type: Object.Type) -> [Object]?
    func fetchObjects<T>(_ type: T.Type, predicate: NSPredicate) -> [T]? where T: Object
}

public class DatabaseManager: DatabaseManagerDataSource {
    
    public static let shared = DatabaseManager()
    private init() {
        Realm.Configuration.defaultConfiguration = config
    }
    
    public func saveObjects<T>(_ objects: [T]) where T: Object {
        do {
            let realm = try Realm()
            debugPrint("User Realm User file location: \(realm.configuration.fileURL?.path ?? "not found")")
            try realm.write {
                realm.add(objects)
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    public func saveObject<T>(_ object: T) where T: Object {
        do {
            let realm = try Realm()
            debugPrint("User Realm User file location: \(realm.configuration.fileURL?.path ?? "not found")")
            try realm.write {
                realm.add(object)
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    public func fetchObjects(_ type: Object.Type) -> [Object]? {
        guard let realm = try? Realm() else { return nil }
        let results = realm.objects(type)
        return Array(results)
    }
    
    public func fetchObjects<T>(_ type: T.Type, predicate: NSPredicate) -> [T]? where T: Object {
        guard let realm = try? Realm() else { return nil }
        return Array(realm.objects(type).filter(predicate))
    }
}
