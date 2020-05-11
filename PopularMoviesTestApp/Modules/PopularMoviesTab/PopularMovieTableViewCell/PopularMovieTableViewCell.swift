//
//  PopularMovieTableViewCell.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 02.05.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import UIKit
import Kingfisher

class PopularMovieTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    var favoriteAction: (()->())?
    let favoriteColor: UIColor = .systemBlue
    let commonColor: UIColor = .gray
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
        titleLabel.text = ""
        descriptionLabel.text = ""
        favoriteButton.tintColor = commonColor
        setPreloadingMode(true)
    }
    
    @IBAction func favoritePressed(_ sender: Any) {
        favoriteAction?()
        favoriteButton.tintColor = (favoriteButton.tintColor == favoriteColor) ? commonColor : favoriteColor
    }
    
    func setupWith(posterPath: String?,
                   title: String?,
                   description: String?,
                   isFavorite: Bool = false,
                   isPreloading: Bool = false,
                   favoriteAction: @escaping ()->()) {
        
        self.favoriteAction = favoriteAction
        setPreloadingMode(isPreloading)
        if let url = URL(string: posterPath ?? "") {
            let resource = ImageResource(downloadURL: url, cacheKey: posterPath)
            posterImageView.kf.setImage(with: resource,
                                    placeholder: UIImage(systemName: "photo"))
        } else {
           posterImageView.image = UIImage(systemName: "photo")
        }

        titleLabel.text = title
        descriptionLabel.text = description
        favoriteButton.tintColor = isFavorite ? favoriteColor : commonColor
    }
    
    private func setPreloadingMode(_ isPreloading: Bool) {
        posterImageView.isHidden = isPreloading
        titleLabel.isHidden = isPreloading
        favoriteButton.isHidden = isPreloading
        descriptionLabel.isHidden = isPreloading
        if isPreloading { spinner.startAnimating() } else { spinner.stopAnimating() }
    }
}


