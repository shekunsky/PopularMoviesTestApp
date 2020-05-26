//
//  PopularMoviesCoordinator.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import UIKit

final class PopularMoviesCoordinator: TabBaseCoordinator {

    lazy var popularMoviesVC = makePopularMoviesViewController()
    override var mainVC: TabBarBaseViewController {
        return popularMoviesVC
    }
}

extension PopularMoviesCoordinator {
    func makePopularMoviesViewController() -> PopularMoviesViewController {
        makeController(from: .main) {
            let viewModel = PopularMoviesViewModel(useCases: useCases, coordinator: self)
            $0.viewModel = viewModel
        }
    }
}

