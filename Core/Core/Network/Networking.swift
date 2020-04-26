//
//  Networking.swift
//  Core
//
//  Created by Alex2 on 20.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Foundation

public protocol Networking {
    func getItems<T: Decodable>(_ path: String, parameters: [String: Any]) -> [T]
}
