//
//  NewsViewModel.swift
//  Moviez
//
//  Created by MacBook  on 13.06.21.
//

import Foundation

protocol NewsViewModelProtocol: AnyObject {
    func fetchAwards(completion: @escaping ([Awards]) -> Void)
    func fetchMovieNews(page: Int, completion: @escaping ([ArticleViewModel]) -> Void)
    func fetchCelebrityNews(page: Int,completion: @escaping ([ArticleViewModel]) -> Void)
    func fetchTvShowNews(page: Int, completion: @escaping ([ArticleViewModel]) -> Void)
    var controller: CoordinatorDelegate {get}
    init(with newsManager: NewsManagerProtocol, awardsManager: AwardsManagerProtocol, controller: CoordinatorDelegate)
}

class NewsViewModel: NewsViewModelProtocol {

    private(set) var controller: CoordinatorDelegate
    private var newsManager: NewsManagerProtocol!
    private var awardsManager: AwardsManagerProtocol!
    
    required init(with newsManager: NewsManagerProtocol, awardsManager: AwardsManagerProtocol, controller: CoordinatorDelegate) {
        self.newsManager = newsManager
        self.awardsManager = awardsManager
        self.controller = controller
    }
    
    func fetchMovieNews(page: Int, completion: @escaping ([ArticleViewModel]) -> Void) {
        newsManager.fetchMovieNews(page: page) { movieNews in
            completion(movieNews.map({ ArticleViewModel(article: $0)}))
        }
    }

    func fetchCelebrityNews(page: Int,completion: @escaping ([ArticleViewModel]) -> Void) {
        newsManager.fetchCelebrityNews(page: page) { celebrityNews in
            completion(celebrityNews.map({ ArticleViewModel(article: $0)}))
        }
    }
    
    func fetchTvShowNews(page: Int, completion: @escaping ([ArticleViewModel]) -> Void){
        newsManager.fetchTvShowNews(page: page) { tvShowNews in
            completion(tvShowNews.map({ ArticleViewModel(article: $0)}))
        }
    }
    
    func fetchAwards(completion: @escaping ([Awards]) -> Void) {
        awardsManager.fetchAwards(completion: completion)
    }
    
}
