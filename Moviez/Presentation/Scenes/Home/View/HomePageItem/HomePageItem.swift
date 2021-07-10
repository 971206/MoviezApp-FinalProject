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
    func configure(with item: TvShows) {
        self.labelRate.text = String(describing: item.voteAverage ?? 0)
        self.labelTitle.text = item.name
        self.labelReleaseDate.text = item.firstAirDate
        let posterURL = URL(string:  BaseURL.imageBaseURL + "\(item.posterURL ?? "")")
        self.imagePoster.kf.setImage(with: posterURL)
    }
    
    func configureMovie(with item: Movies){
        self.labelTitle.text = item.title
        self.labelRate.text = String(item.voteAverage ?? 0 )
        self.labelReleaseDate.text = String(describing: item.releaseDate ?? "")
        let posterURL = URL(string:  BaseURL.imageBaseURL + "\(item.posterURL ?? "")")
        imagePoster.kf.setImage(with: posterURL)
    }
}
