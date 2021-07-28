//
//  NewsCoordinator.swift
//  Moviez
//
//  Created by MacBook  on 14.07.21.
//

import UIKit

final class NewsCoordinator: CoordinatorProtocol {
     var navigationController: UINavigationController?
    var newManager: NewsManagerProtocol?
    
    init(_ window: UIWindow? = nil, navigationController: UINavigationController? = UINavigationController()) {
        self.navigationController = navigationController
        let vc = NewsViewController.instantiateFromStoryboard()
        vc.coordinator = self

        self.navigationController?.viewControllers = [vc]
        newManager = NewsManager()
    }
    
    func proceedToMoreNews(category: String) {
        let vc = MoreNewsViewController.instantiateFromStoryboard()
        vc.coordinator = self
        vc.category = category
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func proceetToNewsDetail(with news: ArticleViewModel) {
        let vc = NewsDetailViewController.instantiateFromStoryboard()
        vc.coordinator = self
        vc.news = news
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
