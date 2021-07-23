//
//  SimilarItem.swift
//  Moviez
//
//  Created by MacBook  on 14.06.21.
//

import UIKit
import Kingfisher

class SimilarItem: UICollectionViewCell {
//MARK: - IBOutlets
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var labelAverageRate: UILabel!
    @IBOutlet weak var labelName: UILabel!
    private let cornerRadius = CGFloat(8)

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpLayout()
    }
    
    private func setUpLayout() {
        itemView.clipsToBounds = true
        itemView.layer.cornerRadius = cornerRadius
        imagePoster.layer.cornerRadius = cornerRadius
        
    }

    func configureItem(with item: SearchModel?) {
        if item?.name == nil {
            self.labelName.text = item?.originalTitle
        } else {
            self.labelName.text = item?.name
        }
        self.labelAverageRate.text = String(item?.voteAverage ?? 0 )
        let posterURL = URL(string:  BaseURL.imageBaseURL + "\(item?.posterURL ?? "")")
        imagePoster.kf.setImage(with: posterURL)
    }
    
    
    
    func configure(with item: FirebaseModelViewModel?) {
        if item?.tvShowTitle == nil {
            self.labelName.text = item?.movieTitle
        } else {
            self.labelName.text = item?.tvShowTitle
        }
        self.labelAverageRate.text = item?.averageRate
        imagePoster.kf.setImage(with: item?.posterURL)
    }
}
