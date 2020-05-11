//
//  Context.swift
//  Core
//
//  Created by Alex2 on 20.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Foundation

final class Context {
    
    let environment: Environment
    let networking: Networking
    let database: FavoriteMoviesOperable
    
    init(environment: Environment,
         networking: Networking,
         database: Database) {
        self.environment = environment
        self.networking = networking
        self.database = database
    }
    
}
