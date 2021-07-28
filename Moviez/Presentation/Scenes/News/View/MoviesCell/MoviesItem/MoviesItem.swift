//
//  MoviesItem.swift
//  Moviez
//
//  Created by MacBook  on 20.07.21.
//

import UIKit

class MoviesItem: UICollectionViewCell {
    
    //MARK: - IBOutlets
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
    
    //MARK: - Configure
    func configure(with item: ArticleViewModel?) {
        self.labelDate.text = item?.publishDate
        self.labelSource.text = item?.sourceName
        self.labelTitle.text = item?.title
        imageNews.kf.setImage(with: item?.imageURL)
    }
}
