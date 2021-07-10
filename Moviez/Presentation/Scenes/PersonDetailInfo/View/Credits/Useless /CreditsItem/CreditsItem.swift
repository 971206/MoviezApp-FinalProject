////
////  CreditsItem.swift
////  Moviez
////
////  Created by MacBook  on 03.07.21.
////
//
//import UIKit
//
//class CreditsItem: UICollectionViewCell {
//    @IBOutlet weak var imagePoster: UIImageView!
//    @IBOutlet weak var labelName: UILabel!
//    @IBOutlet weak var labelAverageRate: UILabel!
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    func configureItem(with item: SearchModel?) {
//        if item?.name == nil {
//            self.labelName.text = item?.originalTitle
//        } else {
//            self.labelName.text = item?.name
//        }
//        self.labelAverageRate.text = String(item?.voteAverage ?? 0 )
//        let posterURL = URL(string:  BaseURL.imageBaseURL + "\(item?.posterURL ?? "")")
//        imagePoster.kf.setImage(with: posterURL)
//    }
//
//}
