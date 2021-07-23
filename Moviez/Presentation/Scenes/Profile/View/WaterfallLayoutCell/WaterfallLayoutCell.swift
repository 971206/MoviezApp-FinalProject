//
//  WaterfallLayoutCell.swift
//  Moviez
//
//  Created by MacBook  on 20.07.21.
//

import UIKit

class WaterfallLayoutCell: UICollectionViewCell {
    @IBOutlet weak var imagePoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
 

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imagePoster.layer.cornerRadius = 20
        imagePoster.layer.masksToBounds = true
    }
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        imagePoster.image = nil
//    }

    func configure(with item: FirebaseModel?) {
        let posterURL = URL(string:  BaseURL.imageBaseURL + "\(item?.imageURL ?? "")")
        imagePoster.kf.setImage(with: posterURL)
    }
    
}
