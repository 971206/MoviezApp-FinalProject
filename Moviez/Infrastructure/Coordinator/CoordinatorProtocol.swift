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
    func onTrendingTvShowClicked(tvShow: TvShows)
    func onTrendingComingSoonTheatersClicked(movie: Movies)
    func proceedToDetailsFromSearchMovieAndTvShowChoosed(with item : SearchModel)
    func proceedToDetailsFromSearchWhenPersonChoosed(with item: SearchModel)
    func proceedToPersonDetailInfo(personId: Int, media: String)
    func proceedToMovieAndTvShowDetailInfo(id: Int, type: String)
    func proceedToSignUp()
    func proceedToProfile() 
    func alertRegistrationProblem(message: String)
    func alertRegistrationSuccess()
    func alertSignInProblem() 
    
}
