//
//  Networking.swift
//  Core
//
//  Created by Alex2 on 20.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import UIKit

public protocol Networking {
    func getPopularMovies(for page: Int, complition: @escaping ([PopularMovie]?) -> Void)
    func fullPathToImageFrom(path: String?) -> String?
    func fullPathToThumbnailFrom(path: String?) -> String?
}
