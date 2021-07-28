//
//  WelcomeCell.swift
//  Moviez
//
//  Created by MacBook  on 27.07.21.
//

import UIKit

class WelcomeCell: UICollectionViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var imgIllustration: UIImageView!
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //MARK: - Configure
    func configure(with item: WelcomePage) {
        self.labelTitle.text = item.title
        self.labelText.text = item.text
        self.imgIllustration.image = UIImage(named: item.imageName)
    }
}
