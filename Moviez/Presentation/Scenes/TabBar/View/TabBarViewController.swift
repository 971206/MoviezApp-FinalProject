//
//  TabBarViewController.swift
//  Moviez
//
//  Created by MacBook  on 05.06.21.
//

import UIKit
import FirebaseAuth
//
//protocol TabBarViewControllerDelegate {
//    func getData()
//}

class TabBarViewController: UITabBarController, Storyboarded, CoordinatorDelegate {
    
    private var homeCoordinator = HomeCoordinator()
    private var searchCoordinator = SearchCoordinator()
    private var newsCoordinator = NewsCoordinator()
    private var profileCoordinator = ProfileCoordinator()
    private var signInCoordinator = SignInCoordinator()
    var coordinator: CoordinatorProtocol?
    
    
    
    // MARK: - VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            homeCoordinator.navigationController!,
            searchCoordinator.navigationController!,
            newsCoordinator.navigationController!,
            signInCoordinator.navigationController!,
//            profileCoordinator.navigationController!
        ]
        
        setupTabbar()
//        addSignInObersver()
//        addSignOutObserver()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabBar()
        checkUserSignedIn()
        addSignInObersver()
        addSignOutObserver()
        
    }
    
    //MARK: - Add Oberver
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
    
    // MARK: - Check user
    func checkUserSignedIn() {
        if Auth.auth().currentUser != nil {
            appendProfileVc()
        } else {
           appendSignIn()
        }
    }
    
    
    //MARK: - Show profile page when user signed in
    @objc func userSignedIn(with: Notification) {
        appendProfileVc()
    }
    
    func appendProfileVc() {
        if Auth.auth().currentUser != nil {
            if let viewControllers = self.viewControllers {
                var controllers = viewControllers
                controllers.removeLast()
                let profileVC = profileCoordinator.navigationController!
                controllers.append(profileVC)
                self.setViewControllers(controllers, animated: true)
            }
        }
    }
    
    //MARK: - Show Sign in page when user signed out
    
    @objc func userSignedOut(with: Notification) {
        appendSignIn()
    }

    func appendSignIn() {
        if let viewControllers = self.viewControllers {
            var controllers = viewControllers
            controllers.removeLast()
            let signInVC = signInCoordinator.navigationController!
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
    }
    
    //MARK: - Setup TabBar
    func setupTabbar() {
        tabBar.tintColor = UIColor(named: "pink")
        tabBar.layer.cornerRadius = 20
        tabBar.layer.masksToBounds = true
        tabBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    

    
  
}

//extension TabBarViewController: TabBarViewControllerDelegate {
//    func getData() {
//        print("get data called")
//    }
//}
// romeli vcdan ginda wamogeba? 

