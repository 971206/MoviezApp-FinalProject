//
//  HomeViewModel.swift
//  Moviez
//
//  Created by MacBook  on 04.07.21.
//

import UIKit

protocol HomeViewModelProtocol: AnyObject {
    func fetchInTheatersMovies(completion: @escaping ([MoviesViewModel]) -> Void)
    func fetchTrendingMovies(completion: @escaping([MoviesViewModel]) -> Void)
    func fetchTrendingTvShows(completion: @escaping([TvShowViewModel]) -> Void)
    func fetchComingSoonMovies(completion: @escaping ([MoviesViewModel]) -> Void)
    
    var controller: CoordinatorDelegate { get }

    init(with inTheatersManager: InTheatersManagerProtocol,
         trendingMoviesManager: TrendingMoviesManagerProtocol,
         trendingTvShowsManager: TrendingTvShowsManagerProtocol,
         comingSoonManager: ComingSoonManagerProtocol,
         controller: CoordinatorDelegate)
}

final class HomeViewModel: HomeViewModelProtocol {
    private var inTheatersManager: InTheatersManagerProtocol!
    private var trendingMoviesManager: TrendingMoviesManagerProtocol!
    private var trendingTvShowsManager: TrendingTvShowsManagerProtocol!
    private var comingSoonManager: ComingSoonManagerProtocol!
    
    private(set) var controller: CoordinatorDelegate

    
    init(with inTheatersManager: InTheatersManagerProtocol,
         trendingMoviesManager: TrendingMoviesManagerProtocol,
         trendingTvShowsManager: TrendingTvShowsManagerProtocol,
         comingSoonManager: ComingSoonManagerProtocol,
         controller: CoordinatorDelegate) {
        
        self.inTheatersManager = inTheatersManager
        self.trendingMoviesManager = trendingMoviesManager
        self.trendingTvShowsManager = trendingTvShowsManager
        self.comingSoonManager = comingSoonManager
        self.controller = controller
    }
    
    
    func fetchInTheatersMovies(completion: @escaping ([MoviesViewModel]) -> Void) {
        inTheatersManager.fetchInTheatersMovies { inTheatersList in
            completion(inTheatersList.map { MoviesViewModel(movies: $0) })
        }
    }
    
    func fetchTrendingMovies(completion: @escaping ([MoviesViewModel]) -> Void) {
        trendingMoviesManager.fetchTrendingMovies { trendingMoviewList in
            completion(trendingMoviewList.map { MoviesViewModel(movies: $0) })
        }
    }
    
    func fetchComingSoonMovies(completion: @escaping ([MoviesViewModel]) -> Void) {
        comingSoonManager.fetchComingSoonMovies { comingSoonList in
            completion(comingSoonList.map { MoviesViewModel(movies: $0) })
        }
    }
    
    func fetchTrendingTvShows(completion: @escaping ([TvShowViewModel]) -> Void) {
        trendingTvShowsManager.fetchTrendingTvShows { trendingTvShowList in
            completion(trendingTvShowList.map { TvShowViewModel(tvShow: $0) })
        }
    }
    
}
