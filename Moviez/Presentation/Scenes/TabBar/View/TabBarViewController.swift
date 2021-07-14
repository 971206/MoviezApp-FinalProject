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
    var coordinator: CoordinatorProtocol?
    var searchCoordinator: CoordinatorProtocol?
    
// MARK: - VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let vc1 = self.viewControllers![0] as! HomeViewController
        vc1.coordinator = coordinator
        
        let vc2 = self.viewControllers![1] as! SearchListViewController
        vc2.coordinator = coordinator
        
//        vc2.tabBarDelegate = self

        let vc3 = self.viewControllers![2] as! NewsViewController
        vc3.coordinator = coordinator

        let vc4 = self.viewControllers![3] as! SignInViewController
        vc4.coordinator = coordinator

        setupTabbar()
        addObersver()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabBar()
        checkUserSignedIn()
    }
    
    //MARK: - Add Oberver
    func addObersver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(userSignedIm(with:)),
            name: .signedIn,
            object: nil)
    }
    
    // MARK: - Check user
    func checkUserSignedIn() {
        if Auth.auth().currentUser != nil {
           appendProfileVc()
        } else {
            print("Not Logged In")
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
    
//MARK: - Show profile page when user signed in
    @objc func userSignedIm(with: Notification) {
        appendProfileVc()
    }
    
    func appendProfileVc() {
        if UserDefaults.standard.bool(forKey: UDKeys.isLoggedIn) {
            if let viewControllers = self.viewControllers {
                var controllers = viewControllers
                controllers.removeLast()
                let sb = UIStoryboard(name: VCIds.profile, bundle: nil)
                let profileVC = sb.instantiateViewController(identifier: VCIds.profile) as! ProfileViewController
                controllers.append(profileVC)
                self.setViewControllers(controllers, animated: true)
            }
        }
    }
}

//extension TabBarViewController: TabBarViewControllerDelegate {
//    func getData() {
//        print("get data called")
//    }
//}
// romeli vcdan ginda wamogeba? 

