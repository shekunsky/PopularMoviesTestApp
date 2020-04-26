//
//  AppDelegate.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 20.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import UIKit
import Core

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private lazy var services: Services = Services(environment: environment)
    private lazy var appCoordinator: AppCoordinator = AppCoordinator(useCases: self.services)
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = appCoordinator.window
        return true
    }

    var environment: Environment {
        if isUITestingEnabled {
            return Environment.development(.test)
        } else {
            return Environment.development(.normal)
        }
    }
    
    var isUITestingEnabled: Bool {
        get { return ProcessInfo.processInfo.arguments.contains("UI-Testing") }
    }
}
