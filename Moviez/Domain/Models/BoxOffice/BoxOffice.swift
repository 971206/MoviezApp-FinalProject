//
//  File.swift
//  Moviez
//
//  Created by MacBook  on 07.06.21.
//

import Foundation

struct BoxOffice: Codable {
    
    let rank: String?
    let title: String?
    let imageURL: String?
    let weekendRevenue: String?
    let totalRevenue: String?
    let weeks: String?
    
    enum CodingKeys: String, CodingKey {
        case rank, title, weeks
        case imageURL       = "image"
        case weekendRevenue = "weekend"
        case totalRevenue = "gross"
    }
    
}
