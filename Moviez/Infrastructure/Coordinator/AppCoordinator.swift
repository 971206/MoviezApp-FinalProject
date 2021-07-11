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
    
    func onTrendingComingSoonTheatersClicked(movie: Movies) {
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

    
    func proceedToDetailsFromSearchMovieAndTvShowChoosed(with item : SearchModel) {
        let detailInfoVC = DetailInfoViewController.instantiateFromStoryboard()
        detailInfoVC.idOfItem = item.id
        detailInfoVC.typeOfItem = item.mediaType
        detailInfoVC.coordinator = self
        navigationController?.pushViewController(detailInfoVC, animated: true)
    }
    
    func proceedToDetailsFromSearchWhenPersonChoosed(with item: SearchModel) {
        let detailsInfoVC = PersonDetailInfoViewController.instantiateFromStoryboard()
        detailsInfoVC.id = item.id
        detailsInfoVC.mediaType = item.mediaType
        detailsInfoVC.coordinator = self
        navigationController?.pushViewController(detailsInfoVC, animated: true)
    }
    
    func proceedToMovieAndTvShowDetailInfo(id: Int, type: String) {
        let detailInfoVC = DetailInfoViewController.instantiateFromStoryboard()
        detailInfoVC.idOfItem = id
        detailInfoVC.typeOfItem = type
        detailInfoVC.coordinator = self
       navigationController?.pushViewController(detailInfoVC, animated: true)
    }

    func proceedToPersonDetailInfo(personId: Int, media: String) {
        let vc = PersonDetailInfoViewController.instantiateFromStoryboard()
        vc.id = personId
        vc.mediaType = media
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
    func proceedToSignUp() {
        let vc =  RegistrationViewController.instantiateFromStoryboard()
        vc.coordinator = self
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    
     func alertRegistrationProblem(message: String) {
        let alert = UIAlertController(title: "There was a problem", message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        navigationController?.present(alert, animated: true)
    }
    
     func alertRegistrationSuccess() {
        let alert = UIAlertController(title: "Congratulations!", message: "User has successfully been registered! Now you can sign in." , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { action in
            self.navigationController?.dismiss(animated: true, completion: nil)
        }))
        navigationController?.present(alert, animated: true)
    }
    
     func alertSignInProblem() {
        let alert = UIAlertController(title: "There was a problem", message: "Details are not correct or user does not exist ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        navigationController?.present(alert, animated: true)
    }
   
}
