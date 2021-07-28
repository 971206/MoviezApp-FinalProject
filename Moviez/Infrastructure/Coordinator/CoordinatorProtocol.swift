//
//  CoordinatorProtocol.swift
//  Moviez
//
//  Created by MacBook  on 10.07.21.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {

    init(_ window: UIWindow?, navigationController: UINavigationController?)
    
    func startWithWelcomePage()
    func startWithTabBar()
    func proceedToTabBar()
    func proceedToDetailsFromSearchMovieAndTvShowChoosed(with item : SearchModel)
    func proceedToDetailsFromSearchWhenPersonChoosed(with item: SearchModel)
    func proceedToMovieAndTvShowDetailInfo(id: Int, mediaType: String)
    func proceedToPersonDetailInfo(personId: Int, mediaType: String)
    func onTrendingComingSoonTheatersClicked(movie: MoviesViewModel)
    func alertRegistrationProblem(message: String)
    func onTrendingTvShowClicked(tvShow: TvShowViewModel)
    func alertRegistrationSuccess()
    func alertLogInProblem()
    func proceedToProfile()
    func proceedToSignUp()
    func proceetToReviews(with itemID: Int, mediaType: String)
    func addToFavorites ()
    func addToWatchlist()
    func proceedToTrailer(with mediaType: String, with itemID: Int)
    func proceedToMoreNews(category: String)
    func proceetToNewsDetail(with news: ArticleViewModel)
    func alertWhenUserAddsInCollection(with title: String) 

}


extension CoordinatorProtocol {

    func startWithWelcomePage(){}
    func startWithTabBar(){}
    func proceedToTabBar() {}
    func proceedToDetailsFromSearchMovieAndTvShowChoosed(with item : SearchModel) {}
    func proceedToDetailsFromSearchWhenPersonChoosed(with item: SearchModel){}
    func proceedToMovieAndTvShowDetailInfo(id: Int, mediaType: String){}
    func proceedToPersonDetailInfo(personId: Int, mediaType: String){}
    func onTrendingComingSoonTheatersClicked(movie: MoviesViewModel) {}
    func alertRegistrationProblem(message: String) {}
    func onTrendingTvShowClicked(tvShow: TvShowViewModel) {}
    func alertRegistrationSuccess() {}
    func alertLogInProblem(){}
    func proceedToProfile() {}
    func proceedToSignUp(){}
    func proceetToReviews(with itemID: Int, mediaType: String) {}
    func addToFavorites (){}
    func addToWatchlist(){}
    func proceedToTrailer(with mediaType: String, with itemID: Int) {}
    func proceedToMoreNews(category: String) {}
    func proceetToNewsDetail(with news: ArticleViewModel) {}
    func alertWhenUserAddsInCollection(with title: String) {}
    
}
