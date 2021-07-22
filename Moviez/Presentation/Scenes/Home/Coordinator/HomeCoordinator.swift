//
//  HomeCoordinator.swift
//  Moviez
//
//  Created by MacBook  on 14.07.21.
//

import UIKit

final class HomeCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController?
    
    init(_ window: UIWindow? = nil, navigationController: UINavigationController? = UINavigationController()) {
        self.navigationController = navigationController
        let vc = HomeViewController.instantiateFromStoryboard()
        vc.coordinator = self
        self.navigationController?.viewControllers = [vc]
    }
    
    func onTrendingComingSoonTheatersClicked(movie: MoviesViewModel) {
        let detailInfoVC = DetailInfoViewController.instantiateFromStoryboard()
        detailInfoVC.idOfItem = movie.id ?? 0
        detailInfoVC.typeOfItem = MediaType.movie.rawValue
        detailInfoVC.coordinator = self
        navigationController?.pushViewController(detailInfoVC, animated: true)
    }
    
    func onTrendingTvShowClicked(tvShow: TvShowViewModel) {
        let detailInfoVC = DetailInfoViewController.instantiateFromStoryboard()
        detailInfoVC.idOfItem = tvShow.id ?? 0
        detailInfoVC.typeOfItem = MediaType.tv.rawValue
        detailInfoVC.coordinator = self
        navigationController?.pushViewController(detailInfoVC, animated: true)
    }
    
    func proceedToMovieAndTvShowDetailInfo(id: Int, mediaType: String) {
        let detailInfoVC = DetailInfoViewController.instantiateFromStoryboard()
        detailInfoVC.idOfItem = id
        detailInfoVC.typeOfItem = mediaType
        detailInfoVC.coordinator = self
        navigationController?.pushViewController(detailInfoVC, animated: true)
    }
    
    func proceedToPersonDetailInfo(personId: Int, mediaType: String) {
        let vc = PersonViewController.instantiateFromStoryboard()
        vc.id = personId
        vc.mediaType = mediaType
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func proceetToReviews(with itemID: Int, mediaType: String) {
        let vc = ReviewsListViewController.instantiateFromStoryboard()
        vc.type = mediaType
        vc.id = itemID
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func proceedToTrailer(with mediaType: String, with itemID: Int) {
        let vc = YoutubeVideoViewController.instantiateFromStoryboard()
        vc.mediaType = mediaType
        vc.itemID = itemID
        vc.coordinator = self
        vc.modalPresentationStyle = .overFullScreen
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    func onBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
