//
//  HomeViewModel.swift
//  Moviez
//
//  Created by MacBook  on 04.07.21.
//

import UIKit

protocol HomeViewModelProtocol: AnyObject {
    func fetchInTheatersMovies(completion: @escaping ([Movies]) -> Void)
    func fetchTrendingMovies(completion: @escaping([Movies]) -> Void)
    func fetchTrendingTvShows(completion: @escaping([TvShows]) -> Void)
    func fetchComingSoonMovies(completion: @escaping ([Movies]) -> Void)
    
    var controller: CoordinatorDelegate { get }

    
    init(with inTheatersManager: InTheatersManagerProtocol, trendingMoviesManager: TrendingMoviesManagerProtocol, trendingTvShowsManager: TrendingTvShowsManagerProtocol, comingSoonManager: ComingSoonManagerProtocol, controller: CoordinatorDelegate)
}

final class HomeViewModel: HomeViewModelProtocol {
    private var inTheatersManager: InTheatersManagerProtocol!
    private var trendingMoviesManager: TrendingMoviesManagerProtocol!
    private var trendingTvShowsManager: TrendingTvShowsManagerProtocol!
    private var comingSoonManager: ComingSoonManagerProtocol!
    
    private(set) var controller: CoordinatorDelegate

    
    init(with inTheatersManager: InTheatersManagerProtocol, trendingMoviesManager: TrendingMoviesManagerProtocol, trendingTvShowsManager: TrendingTvShowsManagerProtocol, comingSoonManager: ComingSoonManagerProtocol, controller: CoordinatorDelegate) {
        self.inTheatersManager = inTheatersManager
        self.trendingMoviesManager = trendingMoviesManager
        self.trendingTvShowsManager = trendingTvShowsManager
        self.comingSoonManager = comingSoonManager
        
        self.controller = controller
    }
    
    
    func fetchInTheatersMovies(completion: @escaping ([Movies]) -> Void) {
        inTheatersManager.fetchInTheatersMovies {  inTheatersList in
            completion(inTheatersList)
        }
    }
    
    func fetchTrendingMovies(completion: @escaping ([Movies]) -> Void) {
        trendingMoviesManager.fetchTrendingMovies { trendingMoviesList in
            completion(trendingMoviesList)
        }
    }
    
    func fetchTrendingTvShows(completion: @escaping ([TvShows]) -> Void) {
        trendingTvShowsManager.fetchTrendingTvShows { trendingTvShowList in
            completion(trendingTvShowList)
            
        }
    }
    
    func fetchComingSoonMovies(completion: @escaping ([Movies]) -> Void) {
        comingSoonManager.fetchComingSoonMovies { comingSoonList in
            completion(comingSoonList)
        }
    }
    
}
