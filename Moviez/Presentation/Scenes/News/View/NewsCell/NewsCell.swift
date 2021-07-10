//
//  NewsCell.swift
//  Moviez
//
//  Created by MacBook  on 13.06.21.
//

import UIKit

class NewsCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    private let cornerRadius = CGFloat(8)
    
    //MARK: - VC Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
       setUpCell()
    }
    
    private func setUpCell() {
        poster.layer.cornerRadius = cornerRadius
        newsView.layer.cornerRadius = cornerRadius
    }
    
    
    func configure(with news: News?) {
        self.labelTitle.text = news?.title
        self.labelTime.text = news?.publishedAt
        self.labelDescription.text = news?.description
        let posterURL = URL(string: news?.urlToImage ?? "")
        poster.kf.setImage(with: posterURL)
    }

}
