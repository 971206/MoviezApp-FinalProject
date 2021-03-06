//
//  SimilarItem.swift
//  Moviez
//
//  Created by MacBook  on 14.06.21.
//

import UIKit
import Kingfisher

class BaseItem: UICollectionViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var labelAverageRate: UILabel!
    @IBOutlet weak var labelName: UILabel!
    
    //MARK: - Private Properties
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
    
    //MARK: - Configure
    
    func configureItem(with item: SearchModel?) {
        if item?.name == nil {
            self.labelName.text = item?.originalTitle
        } else {
            self.labelName.text = item?.name
        }
        let averageRate = String(item?.voteAverage ?? 0.0 )
        self.labelAverageRate.text = averageRate
        
        if let posterURL = item?.posterURL {
            if let url = URL(string: BaseURL.imageBaseURL + posterURL) {
                self.imagePoster.kf.setImage(with: url)
            } else {
                self.imagePoster.image = UIImage(named: "no_poster")
            }
        }
    }
    
    
    func configure(with item: FirebaseModel?) {
        if item?.tvShowTitle == nil {
            self.labelName.text = item?.movieTitle
        } else {
            self.labelName.text = item?.tvShowTitle
        }
        self.labelAverageRate.text = item?.averageRate
        guard let imageURL = item?.imageURL else {return}
        
        let posterURL = URL(string: BaseURL.imageBaseURL + imageURL)
        imagePoster.kf.setImage(with: posterURL)
    }
}
