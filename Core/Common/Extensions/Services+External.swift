//
//  Services+External.swift
//  Core
//
//  Created by Alex2 on 20.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import RealmSwift

extension Services {
    static func setupServices(environment: Environment) {
        setupRealm()
    }
    
    private static func setupRealm() {
        let config = Realm.Configuration(schemaVersion: 0, migrationBlock: Services.migrateDatabase)
        Realm.Configuration.defaultConfiguration = config
        
        do {
            let realm = try Realm()
            if let folderPath = realm.configuration.fileURL?.deletingLastPathComponent().path {
                try FileManager.default.setAttributes([FileAttributeKey.protectionKey: FileProtectionType.none],
                                                      ofItemAtPath: folderPath)
            }
        } catch _ {}
    }
    
    private static func migrateDatabase(_ migration: Migration, _ oldSchemaVersion: UInt64) {
        // We haven’t migrated anything yet, so oldSchemaVersion == 0
        if (oldSchemaVersion < 1) {
            // Nothing to do!
            // Realm will automatically detect new properties and removed properties
            // And will update the schema on disk automatically
        }
    }
}
