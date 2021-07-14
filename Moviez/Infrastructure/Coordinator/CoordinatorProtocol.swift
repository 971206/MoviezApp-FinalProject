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
    
    func proceedToDetailsFromSearchMovieAndTvShowChoosed(with item : SearchModel)
    func proceedToDetailsFromSearchWhenPersonChoosed(with item: SearchModel)
    func proceedToMovieAndTvShowDetailInfo(id: Int, type: String)
    func proceedToPersonDetailInfo(personId: Int, media: String)
    func onTrendingComingSoonTheatersClicked(movie: Movies)
    func alertRegistrationProblem(message: String)
    func onTrendingTvShowClicked(tvShow: TvShows)
    func alertRegistrationSuccess()
    func alertSignInProblem()
    func proceedToProfile()
    func proceedToSignUp()

}
