//
//  TvShowItem.swift
//  Moviez
//
//  Created by MacBook  on 21.07.21.
//

import UIKit

class TvShowItem: UICollectionViewCell {
    
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var labelSource: UILabel!
    @IBOutlet weak var labelDate: UILabel!
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
    
    func configure(with item: ArticleViewModel?) {
        self.labelSource.text = item?.sourceName
        self.labelDate.text = item?.publishDate
        self.labelTitle.text = item?.title
        imageCover.kf.setImage(with: item?.imageURL)
    }
}
