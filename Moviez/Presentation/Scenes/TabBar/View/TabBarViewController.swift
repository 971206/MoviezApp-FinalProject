//
//  TabBarViewController.swift
//  Moviez
//
//  Created by MacBook  on 05.06.21.
//

import UIKit
import FirebaseAuth

class TabBarViewController: UITabBarController, Storyboarded, CoordinatorDelegate {
    
    private var homeCoordinator = HomeCoordinator()
    private var searchCoordinator = SearchCoordinator()
    private var newsCoordinator = NewsCoordinator()
    private var profileCoordinator = ProfileCoordinator()
    private var logInCoordinator = LogInCoordinator()
    var coordinator: CoordinatorProtocol?
    
    
    
    // MARK: - VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UDManager.markOnboarded()
        
        viewControllers = [
            homeCoordinator.navigationController!,
            searchCoordinator.navigationController!,
            newsCoordinator.navigationController!,
            logInCoordinator.navigationController!,
        ]
        addSignInObersver()
        addSignOutObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        setupTabBar()
        checkUserSignedIn()
    }
    
    
    
    //MARK: - Add Obervers
    func addSignInObersver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(userSignedIn(with:)),
            name: .signedIn,
            object: nil)
    }
    
    func addSignOutObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(userSignedOut(with:)),
            name: .signedOut,
            object: nil)
    }
    
    // MARK: - Check user status
    func checkUserSignedIn() {
        if Auth.auth().currentUser != nil {
            appendProfileVc()
        } else {
           appendSignInVc()
        }
    }
    
    
    //MARK: - Show profile page when user signed in
    @objc func userSignedIn(with: Notification) {
        appendProfileVc()
    }
    
    func appendProfileVc() {
        if var viewControllers = self.viewControllers {
            viewControllers.removeLast()
            let profileVC = profileCoordinator.navigationController!
            viewControllers.append(profileVC)
            self.setViewControllers(viewControllers, animated: true)
        }
    }
    
    //MARK: - Show Sign in page when user signed out
    @objc func userSignedOut(with: Notification) {
        appendSignInVc()
    }

    func appendSignInVc() {
        if let viewControllers = self.viewControllers {
            var controllers = viewControllers
            controllers.removeLast()
            let signInVC = logInCoordinator.navigationController!
            controllers.append(signInVC)
            self.setViewControllers(controllers, animated: true)
        }
    }
    
    //MARK: - Setup Tabbar    
    private func setupTabBar() {
        guard let items = tabBar.items else { return }
        items[0].title = "Home"
        items[1].title = "Search"
        items[2].title = "News"
        items[3].title = "Profile"
        items[1].image = UIImage(named: "ic_search")
        tabBar.tintColor = UIColor(named: "pink")
        tabBar.layer.cornerRadius = 20
        tabBar.layer.masksToBounds = true
        tabBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}

