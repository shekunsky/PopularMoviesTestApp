//
//  Convertible.swift
//  Core
//
//  Created by Alex2 on 20.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Foundation

protocol EntityConvertible {
    associatedtype EntityType
    
    func asEntity() -> EntityType
}

protocol ModelConvertible {
    associatedtype ModelType: EntityConvertible
    
    func asModel() -> ModelType
}
