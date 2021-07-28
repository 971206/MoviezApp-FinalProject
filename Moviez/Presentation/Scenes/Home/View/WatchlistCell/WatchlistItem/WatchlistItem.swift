//
//  WatchlistItem.swift
//  Moviez
//
//  Created by MacBook  on 20.07.21.
//

import UIKit

class WatchlistItem: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelMediaType: UILabel!
    @IBOutlet weak var mediaTypeView: UIView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var blurView: UIView!
    
    private let cornerRadius = CGFloat(8)

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        mediaTypeView.layer.cornerRadius = cornerRadius
        mediaTypeView.clipsToBounds = true
        blurView.layer.cornerRadius = cornerRadius
        blurView.clipsToBounds = true
        mediaTypeView.setGradientBackground(colorOne: UIColor(hex: "931BBD"), colorTwo: UIColor(hex: "FD286F"))
        imagePoster.layer.cornerRadius = cornerRadius
    }
    
    //MARK: - Configure
    
    func configure(with item: FirebaseModel?) {

        if item?.tvShowTitle == "" {
            self.labelTitle.text = item?.movieTitle
        } else {
            self.labelTitle.text = item?.tvShowTitle
        }
        self.labelMediaType.text = item?.mediaType?.uppercased()
        guard let imageURL = item?.imageURL else {return}
        let posterURL = URL(string: BaseURL.imageBaseURL + imageURL)
        imagePoster.kf.setImage(with: posterURL)
    }
    
    func configure(with item: SearchModel?) {
        guard let url = item?.posterURL else {return}
        let posterURL = URL(string: BaseURL.imageBaseURL + url)
        imagePoster.kf.setImage(with: posterURL)
        labelTitle.text = item?.mediaType == "movie" ? item?.originalTitle : item?.name
    }
}
