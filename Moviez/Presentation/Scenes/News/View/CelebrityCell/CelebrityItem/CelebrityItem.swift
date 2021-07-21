//
//  CelebrityItem.swift
//  Moviez
//
//  Created by MacBook  on 21.07.21.
//

import UIKit

class CelebrityItem: UICollectionViewCell {

    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelSource: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageCover: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    private func setupLayout() {
        imageCover.layer.cornerRadius = 8
        itemView.clipsToBounds = true
        itemView.layer.cornerRadius = 8
    }

    func configure(with item: Articles?) {
        self.labelSource.text = item?.source?.name 
        self.labelDate.text = "\(item?.publishedAt?.dropLast(10) ?? "")"
        self.labelTitle.text = item?.title
        let imageURL = URL(string: item?.urlToImage ?? "")
        imageCover.kf.setImage(with: imageURL)
    }
    
}
