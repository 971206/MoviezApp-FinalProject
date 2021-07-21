//
//  MoviesItem.swift
//  Moviez
//
//  Created by MacBook  on 20.07.21.
//

import UIKit

class MoviesItem: UICollectionViewCell {

    @IBOutlet weak var moviesItemView: UIView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelSource: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupMoviesItem()
        // Initialization code
    }
    
    func setupMoviesItem() {
        imageNews.layer.cornerRadius = 8
        moviesItemView.setShadow(UIView: moviesItemView, viewCornerRadius: 8)
    }
    
    func configure(with item: Articles?) {
        self.labelDate.text = "\(item?.publishedAt?.dropLast(8) ?? "")"
        self.labelSource.text = item?.source?.name ?? "Unknown Source"
        self.labelTitle.text = item?.title
        let imageURL = URL(string: item?.urlToImage ?? "")
        imageNews.kf.setImage(with: imageURL)
    }

}
