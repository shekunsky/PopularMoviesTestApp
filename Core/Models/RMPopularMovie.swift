//
//  RMPopularMovie.swift
//  Core
//
//  Created by Alex2 on 11.05.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Realm
import RealmSwift

@objcMembers
public class RMPopularMovie: Object {
    public dynamic var id: Int = -1
    public dynamic var poster_path: String = ""
    public dynamic var adult: Bool = false
    public dynamic var overview: String = ""
    public dynamic var release_date: String = ""
    public dynamic var original_title: String = ""
    public dynamic var original_language: String = ""
    public dynamic var title: String = ""
    public dynamic var backdrop_path: String = ""
    public dynamic var popularity: Float = .zero
    public dynamic var vote_count: Int = .zero
    public dynamic var video: Bool = false
    public dynamic var vote_average: Float = .zero
    
    override public class func primaryKey() -> String? { #keyPath(id) }
}

extension RMPopularMovie: EntityConvertible {
    func asEntity() -> PopularMovie {
        return PopularMovie(poster_path: poster_path,
                            adult: adult,
                            overview: overview,
                            release_date: release_date,
                            genre_ids: [],
                            id: id,
                            original_title: original_title,
                            original_language: original_language,
                            title: title,
                            backdrop_path: backdrop_path,
                            popularity: popularity,
                            vote_count: vote_count,
                            video: video,
                            vote_average: vote_average)
    }
}

extension PopularMovie: ModelConvertible {
    func asModel() -> RMPopularMovie {
        return RMPopularMovie.build { object in
            object.id = id ?? -1
            object.poster_path = poster_path ?? ""
            object.adult = adult ?? false
            object.overview = overview ?? ""
            object.release_date = release_date ?? ""
            object.original_title = original_title ?? ""
            object.original_language = original_language ?? ""
            object.title = title ?? ""
            object.backdrop_path = backdrop_path ?? ""
            object.popularity = popularity ?? .zero
            object.vote_count = vote_count ?? .zero
            object.video = video ?? false
            object.vote_average = vote_average ?? .zero
        }
    }
}
