//
//  BaseViewModel.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 11.05.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//


import Core

protocol PopularMoviesOperable {
    func getPopularMovies()
    func setup(cell: PopularMovieTableViewCell, for indexPath: IndexPath, isPreloading: Bool)
    func showDetailsForMovie(at indexPath: IndexPath, from: TabBarBaseViewController)
    var popularMovies: [PopularMovie] { get set }
    var moviesForCurrentPage: [PopularMovie]? { get set }
    var fetchFailed: (()->())? { get set }
    var actionForDetailsScreen: (()->())? { get set }
    var onFetchCompleted: (([IndexPath]?)->())? { get set }
    var maxMoviesToDownload: Int { get }
}

class BaseViewModel: ViewModel, PopularMoviesOperable, UseCasesConsumer {
    typealias UseCases = HasMoviesUseCase
    
    //MARK: - Vars
    var isFetchInProgress = false
    var coordinator: TabBaseCoordinator?
    var currentPage: Int = 0
    var popularMovies: [PopularMovie] = []
    var moviesForCurrentPage: [PopularMovie]? {
        didSet {
            popularMovies.append(contentsOf: moviesForCurrentPage ?? [])
        }
    }
    var fetchFailed: (()->())?
    var reloadTable: (()->())?
    var actionForDetailsScreen: (()->())?
    var onFetchCompleted: (([IndexPath]?)->())?
    var maxMoviesToDownload: Int { 0 }
    
    convenience init(useCases: UseCases, coordinator: TabBaseCoordinator) {
        self.init()
        self.useCases = useCases
        self.coordinator = coordinator
    }
    
    func getPopularMovies() { }
    func favoriteActionWith(movie: PopularMovie) { }
    
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
                        self?.favoriteActionWith(movie: movie)
        }
        
    }
    
    func calculateIndexPathsToReload(from newMovies: [PopularMovie]) -> [IndexPath] {
        let startIndex = popularMovies.count - newMovies.count
        let endIndex = startIndex + newMovies.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func showDetailsForMovie(at indexPath: IndexPath, from: TabBarBaseViewController) {
        let movie = popularMovies[indexPath.row]
        coordinator?.showDetailsFor(movie: movie,
                                    isFavorite: useCases.movies.checkIsFavoriteMovie(id: movie.id ?? 0),
                                    parentVC: from, action: { [weak self] in
                                        self?.favoriteActionWith(movie: movie)
        })
    }
}
