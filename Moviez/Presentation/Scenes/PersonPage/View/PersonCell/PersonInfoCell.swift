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
        // Initialization code
    }
    
    func configure(with person: Person?) {
        let posterURL = URL(string:  BaseURL.imageBaseURL + "\(person?.imageProfile ?? "")")
        imagePerson.kf.setImage(with: posterURL)
        labelName.text = person?.name
        if person?.gender == 1 {
            labelGender.text = "Gender: Female"
        } else {
            labelGender.text = "Gender: Male"
        }
        labelBirthAndDeath.text = "\(person?.birthday ?? "") - \(person?.deathday ?? "")"
        labelBirthPlace.text = "Born in \(person?.birthPlace ?? "")"
        labelKnownFor.text = "Known for \(person?.knownFor ?? "")"
        labelBiography.text = person?.biography
        
        
    }
    
}
