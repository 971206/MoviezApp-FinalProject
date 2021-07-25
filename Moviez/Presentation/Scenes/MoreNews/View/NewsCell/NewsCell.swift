//
//  NewsCell.swift
//  Moviez
//
//  Created by MacBook  on 13.06.21.
//

import UIKit

protocol  NewsCellDelegate: AnyObject {
    func shareNews(cell: NewsCell)
}

class NewsCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    private let cornerRadius = CGFloat(8)
    @IBOutlet weak var buttonShare: UIButton!
    weak var newsCellDelegate: NewsCellDelegate?
    
    //MARK: - VC Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
       setUpCell()
    }
    
    private func setUpCell() {
        poster.layer.cornerRadius = cornerRadius
        newsView.layer.cornerRadius = cornerRadius
    }
    
    
    func configure(with item: ArticleViewModel?) {
        self.labelTitle.text = item?.title
        self.labelTime.text = item?.publishDate
        self.labelDescription.text = item?.description
        poster.kf.setImage(with: item?.imageURL)
    }

    @IBAction func onShare(_ sender: Any) {
        newsCellDelegate?.shareNews(cell: self)
    }
}
