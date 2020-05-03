//
//  FavoriteMoviesViewModel.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Core

final class FavoriteMoviesViewModel: ViewModel, UseCasesConsumer {
    typealias UseCases = HasMoviesUseCase

    var coordinator: FaforiteMoviesCoordinator?
    var favoriteMovies: [PopularMovie]?

    convenience init(useCases: UseCases, coordinator: FaforiteMoviesCoordinator) {
        self.init()
        self.useCases = useCases
        self.coordinator = coordinator
        setup()
    }

    private func setup() {

    }
}
