//
//  SearchResponse.swift
//  Moviez
//
//  Created by MacBook  on 12.06.21.
//

import Foundation

struct SearchResponse: Codable {
    let results: [SearchModel]?
}
