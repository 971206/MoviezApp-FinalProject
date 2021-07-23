//
//  WatchlistItem.swift
//  Moviez
//
//  Created by MacBook  on 20.07.21.
//

import UIKit

class WatchlistItem: UICollectionViewCell {

    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelAverageRate: UILabel!
    @IBOutlet weak var labelMediaType: UILabel!
    @IBOutlet weak var mediaTypeView: UIView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var itemBackgroundView: UIView!
    @IBOutlet weak var blurView: UIView!
    private let cornerRadius = CGFloat(8)

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    private func setupLayout() {
        mediaTypeView.layer.cornerRadius = cornerRadius
        mediaTypeView.clipsToBounds = true
        blurView.layer.cornerRadius = cornerRadius
        blurView.clipsToBounds = true
        
        mediaTypeView.setGradientBackground(colorOne: UIColor(hex: "931BBD"), colorTwo: UIColor(hex: "FD286F"))
        imagePoster.layer.cornerRadius = cornerRadius
        
    }
    
    func configure(with item: FirebaseModelViewModel?) {
        if item?.movieReleaseDate == "" {
            self.labelReleaseDate.text = item?.tvShowReleaseDate
        } else {
            self.labelReleaseDate.text = item?.movieReleaseDate
        }
        
        if item?.tvShowRuntime == "" {
            self.labelDuration.text = item?.movieRuntime
        } else {
            self.labelDuration.text = item?.tvShowRuntime
        }
        
        if item?.tvShowTitle == "" {
            self.labelTitle.text = item?.movieTitle
        } else {
            self.labelTitle.text = item?.tvShowTitle
        }
        self.labelAverageRate.text = item?.averageRate
        self.labelMediaType.text = item?.mediaType
        imagePoster.kf.setImage(with: item?.posterURL)
    }
}
