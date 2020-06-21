//
//  TabBarBaseViewController.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import UIKit

class TabBarBaseViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Vars
    var viewModel: BaseViewModel!
    
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
        navigationController?.isNavigationBarHidden = true
       
        reloadVisibleRows()
    }
    
    func reloadVisibleRows() {
        guard let indexesForReload = tableView.indexPathsForVisibleRows else { return }

        tableView.beginUpdates()
        tableView.reloadRows(at: indexesForReload, with: .fade)
        tableView.endUpdates()
    }
    
    func setupTable() {
        tableView.register(UINib(nibName: tableCellReuseIdentifier,
                                 bundle: Bundle(for: PopularMovieTableViewCell.self)),
                           forCellReuseIdentifier: tableCellReuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.isHidden = true
        tableView.separatorStyle = .none
    }
    
    func bindViewModel() {
        viewModel.reloadTable = { [weak self] in
            self?.reloadVisibleRows()
        }
    }
}

//MARK: - UITableViewDataSource
extension TabBarBaseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.maxMoviesToDownload
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
extension TabBarBaseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.showDetailsForMovie(at: indexPath, from: self)
    }
}

//MARK: - UITableViewDataSourcePrefetching
extension TabBarBaseViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.getPopularMovies()
        }
    }
}

extension TabBarBaseViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        indexPath.row >= viewModel.popularMovies.count
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}



