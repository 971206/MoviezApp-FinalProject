//
//  NewsCoordinator.swift
//  Moviez
//
//  Created by MacBook  on 14.07.21.
//

import UIKit

final class NewsCoordinator: CoordinatorProtocol {
     var navigationController: UINavigationController?
    
    init(_ window: UIWindow? = nil, navigationController: UINavigationController? = UINavigationController()) {
        self.navigationController = navigationController
        let vc = NewsViewController.instantiateFromStoryboard()
        vc.coordinator = self

        self.navigationController?.viewControllers = [vc]
    }
    
    func proceedToMoreNews(newsList: [Articles]) {
        let vc = MoreNewsViewController.instantiateFromStoryboard()
        vc.coordinator = self
        vc.newsList = newsList
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func proceetToNewsDetail(with news: Articles) {
        let vc = NewsDetailViewController.instantiateFromStoryboard()
        vc.coordinator = self
        vc.news = news
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
