//
//  NewsViewModel.swift
//  Moviez
//
//  Created by MacBook  on 13.06.21.
//

import Foundation

protocol NewsViewModelProtocol: AnyObject {
    func fetchAwards(completion: @escaping ([Awards]) -> Void)
    func fetchMovieNews(completion: @escaping ([Articles]) -> Void)
    func fetchCelebrityNews(completion: @escaping ([Articles]) -> Void)
    func fetchTvShowNews(completion: @escaping ([Articles]) -> Void)
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
    
    func fetchMovieNews(completion: @escaping ([Articles]) -> Void) {
        newsManager.fetchMovieNews(completion: completion)
    }
    
    func fetchCelebrityNews(completion: @escaping ([Articles]) -> Void) {
        newsManager.fetchCelebrityNews(completion: completion)
    }
    
    func fetchTvShowNews(completion: @escaping ([Articles]) -> Void) {
        newsManager.fetchTvShowNews(completion: completion)
    }
    
    func fetchAwards(completion: @escaping ([Awards]) -> Void) {
        awardsManager.fetchAwards(completion: completion)
    }
    
}
