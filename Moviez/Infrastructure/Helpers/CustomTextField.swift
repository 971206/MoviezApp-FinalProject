//
//  CustomTextField.swift
//  Moviez
//
//  Created by MacBook  on 10.06.21.
//

import UIKit

class UnderlineTextField {
    static func underlineTextField(_ textfield:UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 253, green: 40, blue: 111, alpha: 1).cgColor
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomLine)
    }
}
