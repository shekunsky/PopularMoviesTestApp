//
//  StoryboardMakeable.swift
//  Core
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Foundation
import UIKit.UIViewController
import UIKit.UIStoryboard

protocol StoryboardMakeable {
    associatedtype Controller: UIViewController = Self
    static func make<T>(storyboard: Storyboards, bundle: Bundle?) -> T.Type
}

extension StoryboardMakeable {
    static func make<T>(storyboard: Storyboards, bundle: Bundle? = nil) -> T {
        let sb = UIStoryboard(name: storyboard.rawValue, bundle: bundle)
        guard let vc = sb.instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could load \(T.self) from storyboard \(sb)")
        }
        return vc
    }
}
