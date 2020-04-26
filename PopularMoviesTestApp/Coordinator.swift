//
//  Coordinator.swift
//  Core
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var rootViewController: UIViewController { get }
    var useCases: UseCasesProvider { get }
    func start()
    func stop()
}

extension Coordinator {
    func makeController<T: Makeable>() -> T where T.Product == T, T: UIViewController {
        return T.make()
    }
    func makeController<T: Makeable>(_ builder: (T.Product) -> Void) -> T where T.Product == T, T: UIViewController {
        let controller: T = T.make(builder)
        return controller
    }
    func makeController<T: StoryboardMakeable>(from storyboard: Storyboards, builder: (T) -> Void) -> T where T.Controller == T {
        let controller: T = T.make(storyboard: storyboard)
        builder(controller)
        return controller
    }
}
