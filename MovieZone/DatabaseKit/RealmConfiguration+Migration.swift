//
//  RealmConfiguration+Migration.swift
//  MovieZone
//
//  Created by Amal K V on 9/4/25.
//

import Foundation

import Foundation
import RealmSwift

public let schemaVersion: UInt64 = 1

public let config = Realm.Configuration(
    // Set the new schema version. This must be greater than the previously used
    // version (if you've never set a schema version before, the version is 0).
    schemaVersion: schemaVersion,
    
    // Set the block which will be called automatically when opening a Realm with
    // a schema version lower than the one set above
    migrationBlock: { migration, oldSchemaVersion in
        debugPrint("Migration - \(migration)")
        debugPrint("Old Schema version - \(oldSchemaVersion)")
    })
