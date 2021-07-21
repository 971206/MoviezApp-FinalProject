//
//  ProfileCoordinator.swift
//  Moviez
//
//  Created by MacBook  on 14.07.21.
//

import UIKit

final class ProfileCoordinator: CoordinatorProtocol {
     var navigationController: UINavigationController?
    
    init(_ window: UIWindow? = nil, navigationController: UINavigationController? = UINavigationController()) {
        self.navigationController = navigationController
        let vc = ProfileViewController.instantiateFromStoryboard()
        vc.coordinator = self
        self.navigationController?.viewControllers = [vc]
    }
    
    func proceedToMovieAndTvShowDetailInfo(id: Int, mediaType: String) {
        let detailInfoVC = DetailInfoViewController.instantiateFromStoryboard()
        detailInfoVC.idOfItem = id
        detailInfoVC.typeOfItem = mediaType
        detailInfoVC.coordinator = self
        self.navigationController?.pushViewController(detailInfoVC, animated: true)
    }
    func onBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func proceedToTrailer(with mediaType: String, with itemID: Int) {
        let vc = YoutubeVideoViewController.instantiateFromStoryboard()
        vc.mediaType = mediaType
        vc.itemID = itemID
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
