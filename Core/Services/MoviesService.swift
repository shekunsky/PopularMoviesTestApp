//
//  MoviesService.swift
//  Core
//
//  Created by Alex2 on 20.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import UIKit

final class MoviesService: NSObject, MoviesUseCase {
    let network: Networking
    public init (context: Context) {
        network = context.networking
        super.init()
    }
    func getPopularMoviesList(for page: Int, complition: @escaping ([PopularMovie]?) -> Void) {
        network.getPopularMovies(for: page) { (response) in
            complition(response)
        }
    }

    func fullPathToImageFrom(path: String?) -> String? {
        return network.fullPathToImageFrom(path: path)
    }
    
    func fullPathToThumbnailFrom(path: String?) -> String? {
        return network.fullPathToThumbnailFrom(path: path)
    }
}
