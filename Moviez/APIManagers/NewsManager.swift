//
//  NewsAPIManager.swift
//  Moviez
//
//  Created by MacBook  on 13.06.21.
//

import Foundation


protocol NewsManagerProtocol: AnyObject {
    func fetchMovieNews(completion: @escaping ([Articles]) -> Void)
    func fetchCelebrityNews(completion: @escaping ([Articles]) -> Void)
    func fetchTvShowNews(completion: @escaping ([Articles]) -> Void)

}

class NewsManager: NewsManagerProtocol {
    func fetchMovieNews(completion: @escaping ([Articles]) -> Void) {
        let url = APIURLS.movieNewsURL
        NetworkManager.shared.get(url: url) { (result: Result<ArticlesResponse, Error>) in
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
    func fetchCelebrityNews(completion: @escaping ([Articles]) -> Void) {
        let url = APIURLS.celebrityNewsURL
        NetworkManager.shared.get(url: url) { (result: Result<ArticlesResponse, Error>) in
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
    func fetchTvShowNews(completion: @escaping ([Articles]) -> Void) {
        let url = APIURLS.tvShowNewsURL
        NetworkManager.shared.get(url: url) { (result: Result<ArticlesResponse, Error>) in
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
