//
//  String+Extension.swift
//  Moviez
//
//  Created by MacBook  on 08.06.21.
//

import Foundation

extension String {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}
