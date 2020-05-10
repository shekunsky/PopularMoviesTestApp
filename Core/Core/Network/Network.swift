//
//  Network.swift
//  Core
//
//  Created by Dima Shvets on 3/21/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit
import Alamofire

final class Network: Networking {
    
    private let apiEndPoint: String
    private let imagesEndPoint: String
    private let thumbnailsEndPoint: String
    
    init(apiEndPoint: String,
         imagesEndPoint: String,
         thumbnailsEndPoint: String) {
        self.apiEndPoint = apiEndPoint
        self.imagesEndPoint = imagesEndPoint
        self.thumbnailsEndPoint = thumbnailsEndPoint
    }

    func getPopularMovies(for page: Int, complition: @escaping ([PopularMovie]?) -> Void) {
        let absolutePath = "\(apiEndPoint)\(page)"
        AF.request(absolutePath).validate().responseDecodable(of: PopularMoviesResult.self) { (response) in
            guard let result = response.value else {
                complition(nil)
                return
            }
            let movies = result.results
            complition(movies)
        }
    }
    
    func fullPathToImageFrom(path: String?) -> String? {
        guard let endPath = path else { return nil }
        return  "\(imagesEndPoint)\(endPath)"
    }
    
    func fullPathToThumbnailFrom(path: String?) -> String? {
        guard let endPath = path else { return nil }
        return  "\(thumbnailsEndPoint)\(endPath)"
    }
}
