//
//  BoxOfficeCell.swift
//  Moviez
//
//  Created by MacBook  on 09.07.21.
//

import UIKit
import Kingfisher

class BoxOfficeItem: UITableViewCell {

    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var labelTotalRevenue: UILabel!
    @IBOutlet weak var labelWeekRevenue: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var viewRank: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewRank.setGradientBackground(colorOne: <#T##UIColor#>, colorTwo: <#T##UIColor#>)
    }

    
    func configure(with item: BoxOffice?) {
        let imageURL = URL(string: item?.imageURL ?? "")
        imagePoster.kf.setImage(with: imageURL)
        labelTotalRevenue.text = item?.totalRevenue
        labelWeekRevenue.text = item?.weekendRevenue
        labelTitle.text = item?.title
    }
}
