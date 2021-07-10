//
//  NewsViewModel.swift
//  Moviez
//
//  Created by MacBook  on 13.06.21.
//

import Foundation

protocol NewsViewModelProtocol: AnyObject {
    func fetchNews(completion: @escaping ([News])-> Void)
    init(with newsManager: NewsManagerProtocol)
}

class NewsViewModel: NewsViewModelProtocol {
    
    private var newsManager: NewsManagerProtocol!
    
    required init(with newsManager: NewsManagerProtocol) {
        self.newsManager = newsManager
    }
    
    func fetchNews(completion: @escaping ([News])-> Void){
        newsManager.fetchNews { news in
            let news = news
            completion(news)
        }
    }
}
