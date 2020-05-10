//
//  ServicesConfiguration.swift
//  Base-Project
//
//  Created by Alex2 on 20.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Foundation

final public class Services: UseCasesProvider {
    
   private let context: Context

    // Services
    private lazy var moviesService = MoviesService(context: context)

    // Services Gateways
    public var movies: MoviesUseCase { return moviesService }

    public init(environment: Environment) {
        Services.setupServices(environment: environment)
        let network = Network(apiEndPoint: environment.baseURLAddress,
                              imagesEndPoint: environment.imagesURLAddress,
                              thumbnailsEndPoint: environment.thumbnailURLAddress)
        let database = Database(configuration: .defaultConfiguration)
        self.context = Context(environment: environment,
                               networking: network,
                               database: database)
    }
}
