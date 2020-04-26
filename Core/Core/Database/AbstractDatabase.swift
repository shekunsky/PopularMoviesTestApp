//
//  AbstractDatabase.swift
//  Core
//
//  Created by Alex2 on 20.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Foundation
import RealmSwift

protocol AbstractDatabase {
    func queryAll<T: ModelConvertible>() -> [T] where T == T.ModelType.EntityType, T.ModelType: Object
    func save<T: ModelConvertible>(_ entity: T) where T == T.ModelType.EntityType, T.ModelType: Object
    func save<T: ModelConvertible>(_ entities: [T]) where T == T.ModelType.EntityType, T.ModelType: Object
    func truncateDatabase()
}
