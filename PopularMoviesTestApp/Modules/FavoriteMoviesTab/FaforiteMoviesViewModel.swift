//
//  FavoriteMoviesViewModel.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Core

final class FavoriteMoviesViewModel: BaseViewModel {
    
    override var maxMoviesToDownload: Int { popularMovies.count }
    
    override func favoriteActionWith(movie: PopularMovie) {
        if useCases.movies.checkIsFavoriteMovie(id: movie.id ?? 0) {
            useCases.movies.deleteFromFavorites(movie: movie)
            if let index = popularMovies.firstIndex(where: { $0.id == movie.id }) {
                popularMovies.remove(at: index)
            }
        } else {
            useCases.movies.addToFavorites(movie: movie)
        }
        reloadTable?()
    }
    
    override func getPopularMovies() {
        let loadedMovies = useCases.movies.getFavoriteMovies()
        
        DispatchQueue.main.async { [weak self] in
            self?.popularMovies = []
            self?.moviesForCurrentPage = loadedMovies
            let indexPathsToReload = self?.calculateIndexPathsToReload(from: loadedMovies)
            self?.onFetchCompleted?(indexPathsToReload)
        }
    }
}
