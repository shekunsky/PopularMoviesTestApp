//
//  UseCasesConsumer.swift
//  Core
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Foundation

public protocol UseCasesConsumer: class {
    associatedtype UseCases
    var useCases: UseCases { get set }
}

private enum UseCasesConsumerKeys {
    static var useCases = "useCases"
}

public extension UseCasesConsumer where Self: NSObject {
    var useCases: UseCases {
        get {
            guard let useCases: UseCases = getAssociatedObject(key: &UseCasesConsumerKeys.useCases) else {
                fatalError("useCases are required")
            }
            return useCases
        }
        set { setAssociatedObject(value: newValue, key: &UseCasesConsumerKeys.useCases, policy: .retain) }
    }
}
