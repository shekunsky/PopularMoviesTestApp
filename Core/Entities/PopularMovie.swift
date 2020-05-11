//
//  PopularMovie.swift
//  Core
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Foundation

public struct PopularMoviesResult: Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [PopularMovie]
}

public struct PopularMovie: Decodable {
    public let poster_path: String?
    public let adult: Bool?
    public let overview: String?
    public let release_date: String?
    public let genre_ids: [Int]?
    public let id: Int?
    public let original_title: String?
    public let original_language: String?
    public let title: String?
    public let backdrop_path: String?
    public let popularity: Float?
    public let vote_count: Int?
    public let video: Bool?
    public let vote_average: Float?
}
