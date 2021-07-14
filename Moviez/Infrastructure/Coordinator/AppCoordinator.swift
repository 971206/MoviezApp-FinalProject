//
//  AppCoordinator.swift
//  Moviez
//
//  Created by MacBook  on 10.07.21.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {

        
    // MARK: - Private properties
    
    private var window: UIWindow?
    private var navigationController: UINavigationController?
    
    // MARK: - Internal properties
    
    init(_ window: UIWindow?, navigationController: UINavigationController?) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = TabBarViewController.instantiateFromStoryboard()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
        navigationController?.isNavigationBarHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
