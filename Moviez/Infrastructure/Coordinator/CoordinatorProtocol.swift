//
//  CoordinatorProtocol.swift
//  Moviez
//
//  Created by MacBook  on 10.07.21.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
//    
//    var networkManager: NetworkManagerProtocol {get}
//    var inTheatersManager: InTheatersManagerProtocol {get}
//    var trendingMoviesManager: TrendingMoviesManagerProtocol {get}
//    var trendingTvShowsManager: TrendingTvShowsManagerProtocol {get}
//    var comingSoonManager: ComingSoonManagerProtocol {get}
    
//    var networkManager: NetworkManagerProtocol {get}
    
    init(_ window: UIWindow?, navigationController: UINavigationController?)
    
    func start()
    func onTrendingMoviesClicked(movie: Movies) 
    func onInTheatersClicked(movie: Movies)
    func onTrendingTvShowClicked(tvShow: TvShows)
    func onComingSoonClicked(movie: Movies)
    func proceedToDetailsMovieAndTvShowChoosed(with item : SearchModel)
    func proceedToDetailsWhenPersonChoosed(with item: SearchModel)
}
