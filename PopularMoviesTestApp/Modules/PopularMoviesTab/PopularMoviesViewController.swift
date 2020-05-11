//
//  PopularMoviesViewController.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import UIKit

class PopularMoviesViewController: TabBarBaseViewController, StoryboardMakeable {

    // MARK: Outlets
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Vars
    var viewModel: PopularMoviesOperable!
    
    // MARK: Constants
    let tableCellReuseIdentifier = "PopularMovieTableViewCell"
    let tableRowHeigh: CGFloat = 100

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        bindViewModel()
        viewModel.getPopularMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupTable() {
        tableView.register(UINib(nibName: tableCellReuseIdentifier,
                                 bundle: Bundle(for: PopularMovieTableViewCell.self)),
                           forCellReuseIdentifier: tableCellReuseIdentifier)
    
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.isHidden = true
    }
    
    private func bindViewModel() {

        viewModel.onFetchCompleted = { [weak self] newIndexPathsToReload in
            guard let newIndexPathsToReload = newIndexPathsToReload,
            let indexPathsToReload = self?.visibleIndexPathsToReload(intersecting: newIndexPathsToReload) else {
                self?.spinner.stopAnimating()
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
                return
            }
            
            self?.tableView.reloadRows(at: indexPathsToReload, with: .automatic)
        }
    }
}

//MARK: - UITableViewDataSource
extension PopularMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.maxMoviesToDownload
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableCellReuseIdentifier, for: indexPath) as? PopularMovieTableViewCell else { return UITableViewCell() }
        let isPreloading = isLoadingCell(for: indexPath)
        viewModel.setup(cell: cell,
                        for: indexPath,
                        isPreloading: isPreloading)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableRowHeigh
    }
}

//MARK: - UITableViewDelegate
extension PopularMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UITableViewDataSourcePrefetching
extension PopularMoviesViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    if indexPaths.contains(where: isLoadingCell) {
      viewModel.getPopularMovies()
    }
  }
}

private extension PopularMoviesViewController {
  func isLoadingCell(for indexPath: IndexPath) -> Bool {
    return indexPath.row >= viewModel.popularMovies.count
  }
  
  func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
    let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
    let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
    return Array(indexPathsIntersection)
  }
}


