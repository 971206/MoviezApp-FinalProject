//
//  TrendingTvShowsItem.swift
//  Moviez
//
//  Created by MacBook  on 07.06.21.
//

import UIKit
import Kingfisher

class HomePageItem: UICollectionViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var labelRate: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var viewOfItem: UIView!
    private let cornerRadius = CGFloat(8)
    
    //MARK: - VC Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpLayout()
    }
    
    private func setUpLayout() {
        viewOfItem.clipsToBounds = true
        viewOfItem.layer.cornerRadius = cornerRadius
        imagePoster.layer.cornerRadius = cornerRadius
    }
    
    //MARK: - Configure
    func configure(with item: TvShowViewModel) {
        self.labelRate.text = item.averageRate
        self.labelTitle.text = item.title
        self.labelReleaseDate.text = item.releaseDate
        self.imagePoster.kf.setImage(with: item.imageURL)
    }
    
    func configureMovie(with item: MoviesViewModel){
        self.labelTitle.text = item.title
        self.labelRate.text = item.averageRate
        self.labelReleaseDate.text = item.releaseDate
        imagePoster.kf.setImage(with: item.imageURL)
    }
}
