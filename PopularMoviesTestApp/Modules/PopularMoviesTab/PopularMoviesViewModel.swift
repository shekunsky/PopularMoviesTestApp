//
//  PopularMoviesViewModel.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Core

final class PopularMoviesViewModel: BaseViewModel {
    
    override var maxMoviesToDownload: Int { 10000 }
    
    override func favoriteActionWith(movie: PopularMovie) {
        if useCases.movies.checkIsFavoriteMovie(id: movie.id ?? 0) {
            useCases.movies.deleteFromFavorites(movie: movie)
        } else {
            useCases.movies.addToFavorites(movie: movie)
        }
        reloadTable?()
    }
    
    override func getPopularMovies() {
        guard !isFetchInProgress else { return }

        isFetchInProgress = true
        currentPage += 1
        useCases.movies.getPopularMoviesList(for: currentPage) { [weak self] (result) in
            
            guard let loadedMovies = result else {
                DispatchQueue.main.async {
                    self?.isFetchInProgress = false
                    self?.fetchFailed?()
                    self?.currentPage -= 1
                }
                return
            }
            DispatchQueue.main.async {
                self?.moviesForCurrentPage = loadedMovies
                self?.isFetchInProgress = false
                if self?.currentPage ?? 0  > 1 {
                    let indexPathsToReload = self?.calculateIndexPathsToReload(from: loadedMovies)
                    self?.onFetchCompleted?(indexPathsToReload)
                } else {
                    self?.onFetchCompleted?(nil)
                }
            }
        }
    }
}
