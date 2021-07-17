//
//  MovieAndTvShowDescriptionCell.swift
//  Moviez
//
//  Created by MacBook  on 27.06.21.
//

import UIKit

class DescriptionCell: UITableViewCell {
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelGenres: UILabel!
    @IBOutlet weak var labelTagline: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelLanguage: UILabel!
    @IBOutlet weak var labelRate: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var labelRuntime: UILabel!
    @IBOutlet weak var buttonReviews: UIButton!
    @IBOutlet weak var buttonAddFavorites: UIButton!
    
    @IBOutlet weak var buttonAddWatchlist: UIButton!
    var typeOfItem: MediaType.RawValue?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
   
    func configure(with item: Details?) {
//        labelTitle.text = typeOfItem == "movie" ? item?.nameMovie : item?.nameTvShow
        
        if item?.nameMovie == nil {
            labelTitle.text = item?.nameTvShow
        } else {
            labelTitle.text = item?.nameMovie
        }
        if item?.releaseDate == nil {
            labelReleaseDate.text = "Released: \(item?.firstAirDate ?? "" )"
        } else {
            labelReleaseDate.text = "Released: \(item?.releaseDate ?? "" )"
        }
        if item?.runtime == nil {
//            labelRuntime.text = "Runtime: \(item?.episodeRunTime?[0] ?? 0 ) Minutes"
        } else {
            labelRuntime.text =  "Runtime: \(item?.runtime ?? 0 ) Minutes"
        }

        labelTagline.text = item?.tagline
        labelLanguage.text = "Language: \(item?.originalLanguage?.uppercased() ?? "")"
        labelRate.text = String(describing: item?.voteAverage ?? 0)
        labelOverview.text = item?.overview
//        labelGenres.text = item?.genres![0].name
        let posterURL = URL(string:  BaseURL.imageBaseURL + "\(item?.posterURL ?? "")")
        self.imagePoster.kf.setImage(with: posterURL)
    }
    
    
    @IBAction func onReviews(_ sender: Any) {
        
    }
}
