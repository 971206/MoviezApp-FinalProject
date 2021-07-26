//
//  CastItem.swift
//  Moviez
//
//  Created by MacBook  on 27.06.21.
//

import UIKit

class CastItem: UICollectionViewCell {
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var labelPersonsRealName: UILabel!
    @IBOutlet weak var labelCharacterName: UILabel!
    private let cornerRadius = CGFloat(8)

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpLayout()
    }
    
    private func setUpLayout() {
        itemView.clipsToBounds = true
        itemView.layer.cornerRadius = cornerRadius
        imageProfile.layer.cornerRadius = cornerRadius
    }
    
    func configure(with person: PersonInfo?) {
        
        if let imageURL = person?.imageProfile {
            let url = URL(string: BaseURL.imageBaseURL + imageURL)
            imageProfile.kf.setImage(with: url)
        } else {
            imageProfile.image = UIImage(named: "no_photo_person")
        }
        labelPersonsRealName.text = person?.name
        labelCharacterName.text = person?.character
    }
}
