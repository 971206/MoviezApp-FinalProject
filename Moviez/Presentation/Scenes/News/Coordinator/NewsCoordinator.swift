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
}
