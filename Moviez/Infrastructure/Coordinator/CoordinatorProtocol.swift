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
    
    var newsManager: NewsManagerProtocol? { get }
    
    init(_ window: UIWindow?, navigationController: UINavigationController?)
    
    
    
    
    
    func start()

    func proceedToDetailsFromSearchMovieAndTvShowChoosed(with item : SearchModel)
    func proceedToDetailsFromSearchWhenPersonChoosed(with item: SearchModel)
    func proceedToMovieAndTvShowDetailInfo(id: Int, mediaType: String)
    func proceedToPersonDetailInfo(personId: Int, mediaType: String)
    func onTrendingComingSoonTheatersClicked(movie: MoviesViewModel)
    func alertRegistrationProblem(message: String)
    func onTrendingTvShowClicked(tvShow: TvShowViewModel)
    func alertRegistrationSuccess()
    func alertSignInProblem()
    func proceedToProfile()
    func proceedToSignUp()
    func proceetToReviews(with itemID: Int, mediaType: String)
    func addToFavorites ()
    func addToWatchlist()
    func proceedToTrailer(with mediaType: String, with itemID: Int)
    func onBack()
    func proceedToMoreNews(newsList: [ArticleViewModel])
    func proceetToNewsDetail(with news: ArticleViewModel)
    func alertItemIsAlreadyInCollection(with collection: String)

}


extension CoordinatorProtocol {
    var newsManager: NewsManagerProtocol? {
        set { print("") }
        get { nil }
    }
    
    func start(){}
    func proceedToDetailsFromSearchMovieAndTvShowChoosed(with item : SearchModel) {}
    func proceedToDetailsFromSearchWhenPersonChoosed(with item: SearchModel){}
    func proceedToMovieAndTvShowDetailInfo(id: Int, mediaType: String){}
    func proceedToPersonDetailInfo(personId: Int, mediaType: String){}
    func onTrendingComingSoonTheatersClicked(movie: MoviesViewModel) {}
    func alertRegistrationProblem(message: String) {}
    func onTrendingTvShowClicked(tvShow: TvShowViewModel) {}
    func alertRegistrationSuccess() {}
    func alertSignInProblem(){}
    func proceedToProfile() {}
    func proceedToSignUp(){}
    func proceetToReviews(with itemID: Int, mediaType: String) {}
    func addToFavorites (){}
    func addToWatchlist(){}
    func proceedToTrailer(with mediaType: String, with itemID: Int) {}
    func onBack() {}
    func proceedToMoreNews(newsList: [ArticleViewModel]) {}
    func proceetToNewsDetail(with news: ArticleViewModel) {}
    func alertItemIsAlreadyInCollection(with collection: String){}
}
