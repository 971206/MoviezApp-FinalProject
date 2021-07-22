//
//  InTheatersItem.swift
//  Moviez
//
//  Created by MacBook  on 18.07.21.
//

import UIKit

class InTheatersItem: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var labelAverageRate: UILabel!
    @IBOutlet weak var labelRuntime: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imagePoster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 8
        imagePoster.layer.cornerRadius = 8
        
    }

    func configure(with item: MoviesViewModel?) {
        self.labelAverageRate.text = item?.averageRate
        self.labelRuntime.text = item?.runtime
        self.labelTitle.text = item?.title
        imagePoster.kf.setImage(with: item?.imageURL)
    }
    
}
