//
//  DetailsScreenViewController.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 22.05.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsScreenViewController: UIViewController, StoryboardMakeable {
    
    //MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var releaseDateValue: UILabel!
    @IBOutlet private weak var adultLabel: UILabel!
    @IBOutlet private weak var adultValue: UILabel!
    @IBOutlet private weak var popularityLabel: UILabel!
    @IBOutlet private weak var popularityValue: UILabel!
    @IBOutlet private weak var votesLabel: UILabel!
    @IBOutlet private weak var votesValue: UILabel!
    @IBOutlet private weak var voteAverageLabel: UILabel!
    @IBOutlet private weak var voteAverageValue: UILabel!
    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    
    //MARK: - Vars
    var viewModel: MovieDetailsOperable!
    
    //MARK: - Actions
    @IBAction func actionButtonPressed(_ sender: Any) {
        viewModel.makeActionOnMovie()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    private func setupUI() {
        //poster
        if let url = URL(string: viewModel.posterPath ?? "") {
            let resource = ImageResource(downloadURL: url, cacheKey: viewModel.movieDetails.poster_path)
            posterImageView.kf.setImage(with: resource,
                                    placeholder: UIImage(systemName: "photo"))
        } else {
           posterImageView.image = UIImage(systemName: "photo")
        }
        
        //labels
        titleLabel.text = viewModel.movieDetails.title
        textView.text = viewModel.movieDetails.overview
        releaseDateValue.text = viewModel.movieDetails.release_date
        adultValue.text = (viewModel.movieDetails.adult ?? false) ? "YES" : "NO"
        popularityValue.text = "\(viewModel.movieDetails.popularity ?? 0)"
        votesValue.text = "\(viewModel.movieDetails.vote_count ?? 0)"
        voteAverageValue.text = "\(viewModel.movieDetails.vote_average ?? 0)"
        
        //button
        actionButton.layer.cornerRadius = actionButton.bounds.height / 2
        actionButton.setTitleColor(.white, for: .normal)
        if viewModel.isFavoriteMovie {
            actionButton.setTitle("REMOVE FROM FAVORITE", for: .normal)
            actionButton.backgroundColor = .red
        } else {
            actionButton.setTitle("ADD TO FAVORITE", for: .normal)
            actionButton.backgroundColor = .systemGreen
        }
    }
}
