//
//  FavoriteMoviesViewController.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: TabBarBaseViewController, StoryboardMakeable {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getPopularMovies()
    }
    
    override func bindViewModel() {
        viewModel.reloadTable = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.onFetchCompleted = { [weak self] newIndexPathsToReload in
            self?.spinner.stopAnimating()
            self?.tableView.isHidden = false
            self?.tableView.reloadData()
        }
    }
}
