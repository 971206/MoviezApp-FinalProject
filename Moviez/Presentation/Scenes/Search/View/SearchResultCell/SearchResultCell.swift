//
//  SearchResultCell.swift
//  Moviez
//
//  Created by MacBook  on 08.06.21.
//

import UIKit
import Kingfisher

class SearchResultCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelAverageRate: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var contenView: UIView!
    @IBOutlet weak var cellView: UIView!
    
    //MARK: - VC LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 8
    }

    
    //MARK: - Configure
    func configure(with item: SearchModel?) {
        guard let item = item else { return }
        labelTitle.text = item.mediaType == "movie" ? item.originalTitle : item.name
        labelAverageRate.text = String(describing: item.voteAverage ?? item.popularity ?? 0.0)
        labelType.text = item.mediaType?.firstUppercased
        labelReleaseDate.text = item.mediaType == MediaType.movie.rawValue ? item.movieReleaseDate : item.tvShowFirstAirDate ?? item.knownFor
        if let posterURL = item.posterURL {
            if let url = URL(string: BaseURL.imageBaseURL + posterURL) {
                self.imagePoster.kf.setImage(with: url)
            }
        } else if let personURL = item.personImage {
            if let url = URL(string: BaseURL.imageBaseURL + personURL) {
                self.imagePoster.kf.setImage(with: url)
            }
        } else {
            self.imagePoster.image = UIImage(named: "no_image")
        }
        
        
        
        
    }
    
}
