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
    
    init(apiEndPoint: String,
         imagesEndPoint: String) {
        self.apiEndPoint = apiEndPoint
        self.imagesEndPoint = imagesEndPoint
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
}
