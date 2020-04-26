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

    init(useCases: UseCasesProvider,
         navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        super.init(useCases: useCases)
    }

    override func start() {
        navigationController.isNavigationBarHidden = true
        navigationController.setViewControllers([mainVC], animated: false)
    }
}
