//
//  Database.swift
//  Core
//
//  Created by Alex2 on 20.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

protocol FavoriteMoviesOperable: AbstractDatabase {
    func checkIsFavoriteMovie(id: Int) -> Bool
    func addToFavorites(movie: PopularMovie)
    func deleteFromFavorites(movie: PopularMovie)
    func getFavoriteMovies() -> [PopularMovie]
}

final class Database: FavoriteMoviesOperable {
    private let configuration: Realm.Configuration
    private var realm: Realm {
        return try! Realm(configuration: self.configuration)
    }
    init(configuration: Realm.Configuration) {
        self.configuration = configuration
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func truncateDatabase() {
        let realm = self.realm
        try? realm.write {
            realm.deleteAll()
        }
    }
    func queryAll<T: ModelConvertible>() -> [T] where T == T.ModelType.EntityType, T.ModelType: Object {
        let result = realm.objects(T.ModelType.self).toArray().map { model -> T in return model.asEntity() }
        return result
    }
    func save<T: ModelConvertible>(_ entity: T) where T == T.ModelType.EntityType, T.ModelType: Object {
        let realm = self.realm
        try? realm.write {
            realm.add(entity.asModel(), update: .modified)
        }
    }
    func save<T: ModelConvertible>(_ entities: [T]) where T == T.ModelType.EntityType, T.ModelType: Object {
        let realm = self.realm
        try? realm.write {
            entities.forEach { (entity) in
                realm.add(entity.asModel(), update: .modified)
            }
        }
    }
    // MARK: - FavoriteMovies
    public func checkIsFavoriteMovie(id: Int) -> Bool {
        let result = realm.objects(RMPopularMovie.self).filter { $0.id == id }
        return result.count > 0
    }
    public func addToFavorites(movie: PopularMovie) {
        guard let id = movie.id,
            !checkIsFavoriteMovie(id: id) else { return }
        save(movie)
    }
    public func deleteFromFavorites(movie: PopularMovie) {
        let movieToDelete = realm.objects(RMPopularMovie.self).filter { $0.id == movie.id }
        let realm = self.realm
        try? realm.write {
            realm.delete(movieToDelete)
        }
    }
    public func getFavoriteMovies() -> [PopularMovie]{
        return queryAll()
    }
}

extension Results {
    public func toAnyCollection() -> AnyRealmCollection<Element> {
        return AnyRealmCollection<ElementType>(self)
    }

    public typealias ElementType = Element
    public func toArray() -> [Element] {
        return Array(self)
    }
}
