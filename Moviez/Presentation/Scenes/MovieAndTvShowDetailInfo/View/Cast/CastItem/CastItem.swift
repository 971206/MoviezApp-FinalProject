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
    
    func configure(with person: Person?) {
        let imageURL = URL(string:  BaseURL.imageBaseURL + "\(person?.imageProfile ?? "")")
        imageProfile.kf.setImage(with: imageURL)
        labelPersonsRealName.text = person?.name
        labelCharacterName.text = person?.character
    }

}
