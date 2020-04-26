//
//  PopularMoviesViewModel.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Core

final class PopularMoviesViewModel: ViewModel, UseCasesConsumer {
    typealias UseCases = HasMoviesUseCase

    var coordinator: PopularMoviesCoordinator?
    var popularMovies: [PopularMovies]?

    convenience init(useCases: UseCases, coordinator: PopularMoviesCoordinator) {
        self.init()
        self.useCases = useCases
        self.coordinator = coordinator
        setup()
    }

    private func setup() {

    }
}
