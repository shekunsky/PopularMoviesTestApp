//
//  MoviesUseCase.swift
//  Core
//
//  Created by Alex2 on 20.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import UIKit

public protocol MoviesUseCase: AutoUseCaseProvider {
    func getPopularMoviesList(for page: Int, complition: @escaping ([PopularMovie]?) -> Void)
    func fullPathToImageFrom(path: String?) -> String?
}
