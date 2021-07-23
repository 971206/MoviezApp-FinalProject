//
//  BoxOffice.swift
//  Moviez
//
//  Created by MacBook  on 22.07.21.
//

import UIKit

class BoxOfficeItem: UICollectionViewCell {
    
    @IBOutlet weak var viewRank: UIView!
    @IBOutlet weak var viewBoxOffice: UIView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var labelTotalRevenue: UILabel!
    @IBOutlet weak var labelWeekRevenue: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelRank: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
        
    }
    
    private func setupLayout() {
        viewBoxOffice.layer.cornerRadius = 8
        viewBoxOffice.clipsToBounds = true
        viewRank.layer.cornerRadius = 20
        viewRank.clipsToBounds = true
    }
    
    func configure(with item: BoxOfficeViewModel?) {
        self.labelRank.text = item?.rank
        self.labelTotalRevenue.text = item?.totalRevenue
        self.labelWeekRevenue.text = item?.weekRevenue
        self.labelTitle.text = item?.title
        imagePoster.kf.setImage(with: item?.imageURL)
    }
}
