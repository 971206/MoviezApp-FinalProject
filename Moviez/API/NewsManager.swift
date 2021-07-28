//
//  NewsAPIManager.swift
//  Moviez
//
//  Created by MacBook  on 13.06.21.
//

import Foundation


protocol NewsManagerProtocol: AnyObject {
    func fetchMovieNews(page: Int, completion: @escaping ([Article]) -> Void)
    func fetchCelebrityNews(page: Int,completion: @escaping ([Article]) -> Void)
    func fetchTvShowNews(page: Int, completion: @escaping ([Article]) -> Void)

}

class NewsManager: NewsManagerProtocol {
    func fetchMovieNews(page: Int, completion: @escaping ([Article]) -> Void) {
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
    func fetchCelebrityNews(page: Int, completion: @escaping ([Article]) -> Void) {
        let url = "\(APIURLS.celebrityNewsURL + "\(page)")" 
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
    func fetchTvShowNews(page: Int, completion: @escaping ([Article]) -> Void) {
        let url = "\(APIURLS.tvShowNewsURL + "\(page)")"
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
