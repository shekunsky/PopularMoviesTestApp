//
//  PopularMoviesViewController.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import UIKit

class PopularMoviesViewController: TabBarBaseViewController, StoryboardMakeable {
    
    override func bindViewModel() {
        super.bindViewModel()
        
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
