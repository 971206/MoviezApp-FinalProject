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
    @IBOutlet weak var imageBackroundView: UIView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var itemBackgroundView: UIView!
    private let cornerRadius = CGFloat(8)

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    private func setupLayout() {
        mediaTypeView.layer.cornerRadius = mediaTypeView.bounds.width / 2
        mediaTypeView.clipsToBounds = true
        mediaTypeView.setGradientBackground(colorOne: UIColor(hex: "931BBD"), colorTwo: UIColor(hex: "FD286F"))
        imageBackroundView.layer.cornerRadius = cornerRadius
        imagePoster.layer.cornerRadius = cornerRadius
        itemBackgroundView.setShadow(UIView: itemBackgroundView, viewCornerRadius: cornerRadius)
        
    }
    
    func configure(with item: FirebaseModel?) {
        if item?.movieReleaseDate == "" {
            self.labelReleaseDate.text = "\(item?.tvShowReleaseDate?.dropLast(6) ?? "" )"
        } else {
            self.labelReleaseDate.text = "\(item?.movieReleaseDate?.dropLast(6) ?? "" )"
        }
        
        if item?.tvshowRuntime == 0 {
            self.labelDuration.text =  Double((item?.movieRuntime ?? 0) * 60).asString(style: .abbreviated)
        } else {
            self.labelDuration.text =  Double((item?.tvshowRuntime ?? 0) * 60).asString(style: .abbreviated)
        }
        
        if item?.tvShowTitle == "" {
            self.labelTitle.text = item?.movieTitle
        } else {
            self.labelTitle.text = item?.tvShowTitle
        }
        
        self.labelAverageRate.text = String(item?.averageRate ?? 0.0)
        self.labelMediaType.text = item?.mediaType?.uppercased()
        let posterURL = URL(string:  BaseURL.imageBaseURL + "\(item?.imageURL ?? "")")
        imagePoster.kf.setImage(with: posterURL)
    }
}
