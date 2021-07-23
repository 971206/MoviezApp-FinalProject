//
//  ArticlesViewModel.swift
//  Moviez
//
//  Created by MacBook  on 23.07.21.
//

import Foundation

class ArticleViewModel {
    var article: Article
    init(article: Article) {
        self.article = article
    }
    
    var sourceName: String? {
        article.source?.name ?? "Unknown Source"
    }
    
    var publishDate: String? {
        "\(article.publishedAt?.dropLast(10) ?? "N/A")"
    }
    var title: String? {
        article.title
    }
    var imageURL: URL? {
        URL(string: article.urlToImage ?? "")
    }
    var description: String? {
        article.description
    }
    
    var content: String? {
        article.content
    }
    
    var fullSourceName: String? {
        "\(article.author ?? ""),  \(article.source?.name ?? "")"
    }
    
    var sourceURL: URL? {
        URL(string: article.url ?? "")
    }
    
}
