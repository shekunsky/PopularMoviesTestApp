//
//  Makeable.swift
//  Core
//
//  Created by Alex2 on 20.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Foundation

protocol Makeable: class {
    associatedtype Product: AnyObject = Self
    static func make() -> Product
}

extension Makeable {
    static func make(_ builder: (Product) -> Void) -> Product {
        let product = make()
        builder(product)
        return product
    }
}
