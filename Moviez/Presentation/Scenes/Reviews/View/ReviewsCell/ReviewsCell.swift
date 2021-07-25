//
//  ReviewsCell.swift
//  Moviez
//
//  Created by MacBook  on 11.06.21.
//

import UIKit

class ReviewsCell: UITableViewCell {
    //MARK: - IBoutlets
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelReview: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var reviewsView: UIView!
    
    //MARK: - VC Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        reviewsView.layer.cornerRadius = 8

    }
    
//MARK: - Configure
    func configure(with review: Review?) {
        self.labelAuthor.text =  "Author: \(review?.author ?? "")"
        self.labelContent.text  = review?.content
    }
}
