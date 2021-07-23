//
//  NewDescriptionCell.swift
//  Moviez
//
//  Created by MacBook  on 19.07.21.
//

import UIKit

class NewDescriptionCell: UITableViewCell {

    @IBOutlet weak var onBack: UIButton!
    @IBOutlet weak var rateStackView: UIStackView!
    @IBOutlet weak var releaseDateStackView: UIStackView!
    @IBOutlet weak var runtimeStackView: UIStackView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var labelTagline: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var viewPlay: UIView!
    @IBOutlet weak var buttonPlayTrailer: UIButton!
    @IBOutlet weak var addToWatchListButton: ButtonAnimationView!
    @IBOutlet weak var addToFavoritesButton: ButtonAnimationView!
    @IBOutlet weak var labelAverageRate: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelRuntime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    private func setupLayout() {
        viewPlay.setGradientBackground(colorOne: UIColor(hex: "931BBD"), colorTwo: UIColor(hex: "FD286F"))
        viewPlay.layer.cornerRadius = 30
        imagePoster.layer.cornerRadius = 20
        viewPlay.layer.masksToBounds = true
        imagePoster.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        addToFavoritesButton.layer.cornerRadius = 8
        addToWatchListButton.layer.cornerRadius = 8

    }

    func configure(with item: MovieTvShowDetailsViewModel?) {
        
        if item?.movieTitle == nil {
            labelTitle.text = item?.tvShowTitle
        } else {
            labelTitle.text = item?.movieTitle
        }
        if item?.movieReleaseDate == nil {
            labelReleaseDate.text = item?.tvShowReleaseDate
        } else {
            labelReleaseDate.text = item?.movieReleaseDate
        }
        if item?.movieRuntime == nil {
            labelRuntime.text = item?.tvShowEpisodeRuntime
        } else {
            labelRuntime.text = item?.movieRuntime
        }
        labelTagline.text = item?.tagline
        labelAverageRate.text = item?.averageVote
        labelOverview.text = item?.overview
        self.imagePoster.kf.setImage(with: item?.posterURL)
    }
    
    
}
