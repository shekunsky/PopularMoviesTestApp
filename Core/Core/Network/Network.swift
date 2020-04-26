//
//  Network.swift
//  Core
//
//  Created by Dima Shvets on 3/21/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import Alamofire

final class Network: Networking {
    
    private let endPoint: String
    
    
    init(_ endPoint: String) {
        self.endPoint = endPoint
    }
    
    func getItems<T: Decodable>(_ path: String, parameters: [String : Any]) -> [T] {
        let absolutePath = "\(endPoint)/\(path)"
        return []
    }
}
