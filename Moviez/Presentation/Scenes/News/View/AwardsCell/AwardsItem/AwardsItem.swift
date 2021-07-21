//
//  AwardsItem.swift
//  Moviez
//
//  Created by MacBook  on 19.07.21.
//

import UIKit

class AwardsItem: UICollectionViewCell {

    @IBOutlet weak var viewItem: UIView!
    @IBOutlet weak var labelAward: UILabel!
    @IBOutlet weak var imageCover: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewItem.setShadow(UIView: viewItem, viewCornerRadius: 8)
        imageCover.layer.cornerRadius = 8
    }
    
    func configure(with item: Awards?) {
        self.labelAward.text = item?.award
        let imgURL = URL(string: item?.imgURL ?? "")
        imageCover.kf.setImage(with: imgURL)
    }

}
