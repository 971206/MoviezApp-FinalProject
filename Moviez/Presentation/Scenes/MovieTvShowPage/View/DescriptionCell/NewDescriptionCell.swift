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

    }

    func configure(with item: Details?) {
        
        if item?.nameMovie == nil {
            labelTitle.text = item?.nameTvShow
        } else {
            labelTitle.text = item?.nameMovie
        }
        if item?.releaseDate == nil {
            labelReleaseDate.text = "\(item?.firstAirDate?.dropLast(6) ?? "" )"
        } else {
            labelReleaseDate.text = "\(item?.releaseDate?.dropLast(6) ?? "" )"
        }
        if item?.runtime == nil {
//            labelRuntime.text = String(item?.episodeRunTime?[0] ?? 0)
        } else {
            labelRuntime.text = Double((item?.runtime ?? 0) * 60).asString(style: .abbreviated)
        }
        
        labelTagline.text = item?.tagline
        labelAverageRate.text = String(describing: item?.voteAverage ?? 0)
        labelOverview.text = item?.overview
        let posterURL = URL(string:  BaseURL.imageBaseURL + "\(item?.posterURL ?? "")")
        self.imagePoster.kf.setImage(with: posterURL)
    }
    
    
}
