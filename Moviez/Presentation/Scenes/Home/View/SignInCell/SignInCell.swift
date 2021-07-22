//
//  SignInCell.swift
//  Moviez
//
//  Created by MacBook  on 22.07.21.
//

import UIKit

class SignInCell: UITableViewCell {

    @IBOutlet weak var buttonSignIn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
       configureButtonSignIn()
    }
    
    func configureButtonSignIn() {
        buttonSignIn.layer.cornerRadius = 8
    }
    
}
