//
//  AppCoordinator.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import UIKit
import Core
import UIWindowTransitions

final class AppCoordinator: NavigationCoordinator {

    // MARK: - Properties
    let window: UIWindow
    override var rootViewController: UIViewController {
        return tabbarController
    }
    private var tabbarController: UITabBarController
    private var tabs: [NavigationCoordinator] = []

    init(window: UIWindow = UIWindow(frame: UIScreen.main.bounds), useCases: UseCasesProvider,
         rootViewController: UITabBarController = UITabBarController()) {
        
        self.window = window
        self.tabbarController = rootViewController
        super.init(useCases: useCases)
        start()
    }

    override func start() {

        tabs = [PopularMoviesCoordinator(useCases: useCases, navigationController: rootViewController.navigationController ?? UINavigationController()),
                FaforiteMoviesCoordinator(useCases: useCases)]

        let controllers = [tabs[0].rootViewController,
                           tabs[1].rootViewController]
        tabbarController.setViewControllers(controllers, animated: false)
        tabs.forEach { (coordinator) in
            coordinator.start()
        }
        window.setRootViewController(rootViewController)
    }

    override func stop() {
        tabbarController.setViewControllers([], animated: false)
    }
}
