//
//  AppCoordinator.swift
//  Moviez
//
//  Created by MacBook  on 10.07.21.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
//    
//    var inTheatersManager: InTheatersManagerProtocol
//    
//    var trendingMoviesManager: TrendingMoviesManagerProtocol
//    
//    var trendingTvShowsManager: TrendingTvShowsManagerProtocol
//    
//    var comingSoonManager: ComingSoonManagerProtocol
    
    
    // MARK: - Private properties
    
    private var window: UIWindow?
    private var navigationController: UINavigationController?
    
    // MARK: - Internal properties
        
    init(_ window: UIWindow?, navigationController: UINavigationController?) {
        self.window = window
        self.navigationController = navigationController
//        self.trendingMoviesManager = TrendingMoviesManager()
//        self.trendingTvShowsManager = TrendingTvShowsManager()
//        self.comingSoonManager = ComingSoonManager()
//        self.inTheatersManager = InTheatersManager()
        
    }
    
    func start() {
        let vc = TabBarViewController.instantiateFromStoryboard()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func onTrendingMoviesClicked(movie: Movies) {
        let detailInfoVC = DetailInfoViewController.instantiateFromStoryboard()
        detailInfoVC.idOfItem = movie.id ?? 0
        detailInfoVC.typeOfItem = MediaType.movie.rawValue
        detailInfoVC.coordinator = self
        navigationController?.pushViewController(detailInfoVC, animated: true)
    }
    
    func onInTheatersClicked(movie: Movies) {
        let detailInfoVC = DetailInfoViewController.instantiateFromStoryboard()
        detailInfoVC.idOfItem = movie.id ?? 0
        detailInfoVC.typeOfItem = MediaType.movie.rawValue
        detailInfoVC.coordinator = self
        navigationController?.pushViewController(detailInfoVC, animated: true)
    }
    
    func onTrendingTvShowClicked(tvShow: TvShows) {
        let detailInfoVC = DetailInfoViewController.instantiateFromStoryboard()
        detailInfoVC.idOfItem = tvShow.id ?? 0
        detailInfoVC.typeOfItem = MediaType.tv.rawValue
        detailInfoVC.coordinator = self
        navigationController?.pushViewController(detailInfoVC, animated: true)
    }
    
    func onComingSoonClicked(movie: Movies) {
        let detailInfoVC = DetailInfoViewController.instantiateFromStoryboard()
        detailInfoVC.idOfItem = movie.id ?? 0
        detailInfoVC.typeOfItem = MediaType.movie.rawValue
        detailInfoVC.coordinator = self
        navigationController?.pushViewController(detailInfoVC, animated: true)
    }
    
    func proceedToDetailsMovieAndTvShowChoosed(with item : SearchModel) {
        let detailInfoVC = DetailInfoViewController.instantiateFromStoryboard()
        detailInfoVC.idOfItem = item.id
        detailInfoVC.typeOfItem = item.mediaType
        detailInfoVC.coordinator = self
        navigationController?.pushViewController(detailInfoVC, animated: true)
    }
    
        func proceedToDetailsWhenPersonChoosed(with item: SearchModel) {
            let detailsInfoVC = PersonDetailInfoViewController.instantiateFromStoryboard()
            detailsInfoVC.id = item.id
            detailsInfoVC.mediaType = item.mediaType
            detailsInfoVC.coordinator = self
            navigationController?.pushViewController(detailsInfoVC, animated: true)
        }
    

}
