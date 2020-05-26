//
//  TabBaseCoordinator.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import UIKit
import Core

class TabBaseCoordinator: NavigationCoordinator {

    override var rootViewController: UIViewController {
        return navigationController
    }
    private let navigationController: UINavigationController
    var mainVC: TabBarBaseViewController {
        return TabBarBaseViewController()
    }
    lazy var movieDetailsVC = makeMovieDetailsViewController()

    init(useCases: UseCasesProvider,
         navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        super.init(useCases: useCases)
    }

    override func start() {
        navigationController.isNavigationBarHidden = true
        navigationController.setViewControllers([mainVC], animated: false)
    }
    
    func showDetailsFor(movie: PopularMovie, isFavorite: Bool, parentVC: TabBarBaseViewController, action: (()->Void)?) {
        let viewModel = DetailsScreenViewModel(movieDetails: movie, isFavoriteMovie: isFavorite, useCases: useCases, coordinator: self, action: action)
        movieDetailsVC.viewModel = viewModel
        parentVC.present(movieDetailsVC, animated: true, completion: nil)
    }
}

extension TabBaseCoordinator {
    func makeMovieDetailsViewController() -> DetailsScreenViewController {
        makeController(from: .main) { _ in }
    }
}

