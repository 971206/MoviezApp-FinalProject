//
//  NewsAPIManager.swift
//  Moviez
//
//  Created by MacBook  on 13.06.21.
//

import Foundation


protocol NewsManagerProtocol: AnyObject {
    func fetchNews(completion: @escaping ([News]) -> Void)
}

class NewsManager: NewsManagerProtocol {
    func fetchNews(completion: @escaping ([News]) -> Void) {
        let url = APIURLS.newsURL
        NetworkManager.shared.get(url: url) { (result: Result<NewsResponse, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    completion(response.articles ?? [])
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
