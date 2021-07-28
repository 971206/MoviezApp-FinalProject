//
//  MoreNewsViewModel.swift
//  Moviez
//
//  Created by MacBook  on 27.07.21.
//

import Foundation

protocol MoreNewsViewModelProtcol: AnyObject {
    func fetchMovieNews(page: Int, completion: @escaping ([ArticleViewModel]) -> Void)
    func fetchCelebrityNews(page: Int,completion: @escaping ([ArticleViewModel]) -> Void)
    func fetchTvShowNews(page: Int, completion: @escaping ([ArticleViewModel]) -> Void)
    var controller: CoordinatorDelegate {get}
    init(with newsManager: NewsManagerProtocol, controller: CoordinatorDelegate)
}

class MoreNewsViewModel: MoreNewsViewModelProtcol {

    private(set) var controller: CoordinatorDelegate
    private var newsManager: NewsManagerProtocol!
    
    required init(with newsManager: NewsManagerProtocol, controller: CoordinatorDelegate) {
        self.newsManager = newsManager
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
    
}
