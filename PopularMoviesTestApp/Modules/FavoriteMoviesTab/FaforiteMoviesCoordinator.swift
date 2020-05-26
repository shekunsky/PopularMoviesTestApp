//
//  FaforiteMoviesCoordinator.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import UIKit

final class FaforiteMoviesCoordinator: TabBaseCoordinator {

    lazy var favoriteMoviesVC = makeFavoriteMoviesViewController()
    override var mainVC: TabBarBaseViewController {
        return favoriteMoviesVC
    }
}

extension FaforiteMoviesCoordinator {
    func makeFavoriteMoviesViewController() -> FavoriteMoviesViewController {
        makeController(from: .main) {
            let viewModel = FavoriteMoviesViewModel(useCases: useCases, coordinator: self)
            $0.viewModel = viewModel
        }
    }
}

