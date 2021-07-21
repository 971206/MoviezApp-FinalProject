//
//  UITableViewCell + Extension.swift
//  Moviez
//
//  Created by MacBook  on 19.07.21.
//

import Foundation

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle.main)
    }
}
