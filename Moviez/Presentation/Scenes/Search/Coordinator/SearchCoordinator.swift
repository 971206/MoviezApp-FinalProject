//
//  SearchCoordinator.swift
//  Moviez
//
//  Created by MacBook  on 14.07.21.
//

import UIKit

final class SearchCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController?
    
    init(_ window: UIWindow? = nil, navigationController: UINavigationController? = UINavigationController()) {
        self.navigationController = navigationController
        let vc = SearchListViewController.instantiateFromStoryboard()
        vc.coordinator = self

        self.navigationController?.viewControllers = [vc]
    }
    
    func proceedToDetailsFromSearchMovieAndTvShowChoosed(with item : SearchModel) {
        let detailInfoVC = DetailInfoViewController.instantiateFromStoryboard()
        detailInfoVC.idOfItem = item.id
        detailInfoVC.typeOfItem = item.mediaType
        detailInfoVC.coordinator = self
        navigationController?.pushViewController(detailInfoVC, animated: true)
    }
    
    func proceedToDetailsFromSearchWhenPersonChoosed(with item: SearchModel) {
        let detailsInfoVC = PersonViewController.instantiateFromStoryboard()
        detailsInfoVC.id = item.id
        detailsInfoVC.mediaType = item.mediaType
        detailsInfoVC.coordinator = self
        navigationController?.pushViewController(detailsInfoVC, animated: true)
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
    func alertWhenUserAddsInCollection(with title: String) {
       let alert = UIAlertController(title: title, message: "" , preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { action in
           self.navigationController?.dismiss(animated: true, completion: nil)
       }))
       self.navigationController?.present(alert, animated: true)
   }
    
}
