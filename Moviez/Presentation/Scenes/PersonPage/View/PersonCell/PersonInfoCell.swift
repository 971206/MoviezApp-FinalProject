//
//  PersonDetailInfoCell.swift
//  Moviez
//
//  Created by MacBook  on 01.07.21.
//

import UIKit

class PersonInfoCell: UITableViewCell {

    @IBOutlet weak var imagePerson: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelGender: UILabel!
    @IBOutlet weak var labelBirthAndDeath: UILabel!
    
    @IBOutlet weak var labelBirthPlace: UILabel!
    @IBOutlet weak var labelKnownFor: UILabel!
    @IBOutlet weak var labelBiography: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imagePerson.layer.cornerRadius = 20
  
        imagePerson.layer.maskedCorners = [.layerMinXMaxYCorner, . layerMinXMinYCorner]
     
    }
    
    func configure(with item: PersonInfoViewModel?) {
        imagePerson.kf.setImage(with: item?.posterURL )
        labelName.text = item?.name
        if item?.gender == 1 {
            labelGender.text = item?.female
        } else {
            labelGender.text = item?.male
        }
        labelBirthAndDeath.text = item?.birthday
        labelBirthPlace.text = item?.bornPlace
        labelKnownFor.text = item?.knownFor
        labelBiography.text = item?.biography
    }
    
}
