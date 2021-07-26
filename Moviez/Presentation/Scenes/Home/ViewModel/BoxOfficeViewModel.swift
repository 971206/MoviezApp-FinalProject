//
//  BoxOfficeViewModel.swift
//  Moviez
//
//  Created by MacBook  on 22.07.21.
//

import Foundation

struct BoxOfficeViewModel {
    
    private var boxOffice: BoxOffice
    
    init(boxOffice : BoxOffice) {
        self.boxOffice = boxOffice
    }
    
    var rank: String? {
        boxOffice.rank
    }
    
    var weekRevenue: String? {
        "Revenue in this week: \(boxOffice.weekendRevenue ?? "")"
    }
    
    var totalRevenue: String? {
        "Total \(boxOffice.totalRevenue ?? "") in \(boxOffice.weeks ?? "") weeks"
    }
    
    var title: String? {
        boxOffice.title
    }
    
    var imageURL: URL? {
        URL(string: boxOffice.imageURL ?? "")
    }
    
    
}
