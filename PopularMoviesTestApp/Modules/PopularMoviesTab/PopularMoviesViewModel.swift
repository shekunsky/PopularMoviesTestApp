//
//  PopularMoviesViewModel.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Core

protocol PopularMoviesOperable {
    func getPopularMovies()
    func setup(cell: PopularMovieTableViewCell, for indexPath: IndexPath, isPreloading: Bool)
    var popularMovies: [PopularMovie] { get set }
    var moviesForCurrentPage: [PopularMovie]? { get set }
    var fetchFailed: (()->())? { get set }
    var onFetchCompleted: (([IndexPath]?)->())? { get set }
    var maxMoviesToDownload: Int { get }
}

final class PopularMoviesViewModel: ViewModel, PopularMoviesOperable, UseCasesConsumer {
    typealias UseCases = HasMoviesUseCase

    //MARK: - Vars
    private var isFetchInProgress = false
    private var coordinator: PopularMoviesCoordinator?
    private var currentPage: Int = 0
    var popularMovies: [PopularMovie] = []
    var moviesForCurrentPage: [PopularMovie]? {
        didSet {
            popularMovies.append(contentsOf: moviesForCurrentPage ?? [])
        }
    }
    var fetchFailed: (()->())?
    var onFetchCompleted: (([IndexPath]?)->())?
    let maxMoviesToDownload = 10000

    convenience init(useCases: UseCases, coordinator: PopularMoviesCoordinator) {
        self.init()
        self.useCases = useCases
        self.coordinator = coordinator
        setup()
    }

    private func setup() {

    }
    
    func getPopularMovies() {
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
    
    func setup(cell: PopularMovieTableViewCell, for indexPath: IndexPath, isPreloading: Bool) {
        guard indexPath.row < popularMovies.count else { return }
        let movie = popularMovies[indexPath.row]
        let thumbnailPath = useCases.movies.fullPathToThumbnailFrom(path: movie.poster_path)
        cell.setupWith(posterPath: thumbnailPath,
                       title: movie.title,
                       description: movie.overview,
                       isFavorite: useCases.movies.checkIsFavoriteMovie(id: movie.id ?? 0),
                       isPreloading: isPreloading) { [weak self] in
                        
                        //favoriteAction
                        if self?.useCases.movies.checkIsFavoriteMovie(id: movie.id ?? 0) ?? false {
                            self?.useCases.movies.deleteFromFavorites(movie: movie)
                        } else {
                            self?.useCases.movies.addToFavorites(movie: movie)
                        }
        }
        
    }
    
    private func calculateIndexPathsToReload(from newMovies: [PopularMovie]) -> [IndexPath] {
      let startIndex = popularMovies.count - newMovies.count
      let endIndex = startIndex + newMovies.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
