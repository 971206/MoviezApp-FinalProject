//
//  Utilities.swift
//  Moviez
//
//  Created by MacBook  on 05.06.21.
//

import Foundation


class Utilities {
   static func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$")
        return passwordTest.evaluate(with: password)
    }

}
