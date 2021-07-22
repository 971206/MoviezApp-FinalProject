//
//  BoxOffice.swift
//  Moviez
//
//  Created by MacBook  on 22.07.21.
//

import UIKit

class BoxOfficeItem: UICollectionViewCell {

    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var labelTotalRevenue: UILabel!
    @IBOutlet weak var labelWeekRevenue: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelRank: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with item: BoxOfficeViewModel?) {
        self.labelRank.text = item?.rank
        self.labelTotalRevenue.text = item?.totalRevenue
        self.labelWeekRevenue.text = item?.weekRevenue
        self.labelTitle.text = item?.title
        imagePoster.kf.setImage(with: item?.imageURL)
    }
    

}
