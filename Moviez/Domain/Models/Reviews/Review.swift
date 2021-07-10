//
//  Review.swift
//  Moviez
//
//  Created by MacBook  on 11.06.21.
//

import Foundation

struct Review : Codable {
    let author: String?
    let content: String?
    let createTime: String?

    enum CodingKeys: String, CodingKey {
        case author, content
        case createTime   = "created_at"
    }
}
