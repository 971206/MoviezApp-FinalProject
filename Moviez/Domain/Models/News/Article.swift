//
//  News.swift
//  Moviez
//
//  Created by MacBook  on 13.06.21.
//

import Foundation

struct Article: Codable {
    let source: ArticleSource?
    let title: String?
    let author: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct ArticleSource: Codable {
    let id: String?
    let name: String?
}
