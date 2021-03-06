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
    func fetchBoxOfficeInfo(completion: @escaping ([BoxOfficeViewModel]) -> Void)
    func fetchUsersWatchlist(completion: @escaping([FirebaseModel]) -> Void)
    func fetchUsersFavorites(completion: @escaping([FirebaseModel]) -> Void)
    func fetchRecommendedItems(with type: String, id: Int, completion: @escaping ([SearchModel]) -> Void)

    
    var controller: CoordinatorDelegate { get }

    init(with inTheatersManager: InTheatersManagerProtocol,
         trendingMoviesManager: TrendingMoviesManagerProtocol,
         trendingTvShowsManager: TrendingTvShowsManagerProtocol,
         comingSoonManager: ComingSoonManagerProtocol,
         boxOfficeManager: BoxOfficeManagerProtocol,
         firebaseManager: FirebaseManagerProtocol,
         recommendedManager: RecommendedManagerProtocol,
         controller: CoordinatorDelegate)
}

final class HomeViewModel: HomeViewModelProtocol {
 
    

    private var inTheatersManager: InTheatersManagerProtocol!
    private var trendingMoviesManager: TrendingMoviesManagerProtocol!
    private var trendingTvShowsManager: TrendingTvShowsManagerProtocol!
    private var comingSoonManager: ComingSoonManagerProtocol!
    private var boxOfficeManager: BoxOfficeManagerProtocol!
    private var firebaseManager: FirebaseManagerProtocol!
    private var recommendedManager: RecommendedManagerProtocol!
    
    private(set) var controller: CoordinatorDelegate

    
    init(with inTheatersManager: InTheatersManagerProtocol,
         trendingMoviesManager: TrendingMoviesManagerProtocol,
         trendingTvShowsManager: TrendingTvShowsManagerProtocol,
         comingSoonManager: ComingSoonManagerProtocol,
         boxOfficeManager: BoxOfficeManagerProtocol,
         firebaseManager: FirebaseManagerProtocol,
         recommendedManager: RecommendedManagerProtocol,
         controller: CoordinatorDelegate) {
        
        self.inTheatersManager = inTheatersManager
        self.trendingMoviesManager = trendingMoviesManager
        self.trendingTvShowsManager = trendingTvShowsManager
        self.comingSoonManager = comingSoonManager
        self.boxOfficeManager = boxOfficeManager
        self.firebaseManager = firebaseManager
        self.recommendedManager = recommendedManager
        self.controller = controller
    }
    
   
    func fetchUsersWatchlist(completion: @escaping ([FirebaseModel]) -> Void) {
        firebaseManager.fetchUsersWatchlist(completion: completion)
    }
    func fetchUsersFavorites(completion: @escaping([FirebaseModel]) -> Void) {
        firebaseManager.fetchUsersFavorites(completion: completion)
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
    
    func fetchBoxOfficeInfo(completion: @escaping ([BoxOfficeViewModel]) -> Void) {
        boxOfficeManager.fetchBoxOfficeInfo { boxOfficeList in
            completion(boxOfficeList.map({ BoxOfficeViewModel(boxOffice: $0)}))
        }
    }
    func fetchRecommendedItems(with type: String, id: Int, completion: @escaping ([SearchModel]) -> Void) {
        recommendedManager.fetchRecommendedItems(with: type, id: id, completion: completion)
    }

}
