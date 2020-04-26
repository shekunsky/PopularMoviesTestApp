//
//  NavigationCoordinator.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import UIKit
import Core

class NavigationCoordinator: NSObject, Coordinator {
    var rootViewController: UIViewController { fatalError("Coordinator should have rootViewController") }
    let useCases: UseCasesProvider

    func start() { fatalError("Not implemented") }
    func stop() { }

    init(useCases: UseCasesProvider) {
        self.useCases = useCases
    }

    deinit {
        print("'\(type(of: self))' \(#function)")
    }
}
