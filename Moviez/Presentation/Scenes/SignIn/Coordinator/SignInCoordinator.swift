//
//  Coordinator.swift
//  Moviez
//
//  Created by MacBook  on 14.07.21.
//

import UIKit

final class SignInCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController?
    
    init(_ window: UIWindow? = nil, navigationController: UINavigationController? = UINavigationController()) {
        self.navigationController = navigationController
        let vc = SignInViewController.instantiateFromStoryboard()
        vc.coordinator = self
        
        self.navigationController?.viewControllers = [vc]
    }
    
    func proceedToSignUp() {
        let vc =  RegistrationViewController.instantiateFromStoryboard()
        vc.coordinator = self
        navigationController?.present(vc, animated: true, completion: nil)
    }

    func alertRegistrationProblem(message: String) {
        let alert = UIAlertController(title: "There was a problem", message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.navigationController?.present(alert, animated: true)
    }
    
    func alertRegistrationSuccess() {
        let alert = UIAlertController(title: "Congratulations!", message: "User has successfully been registered! Now you can sign in." , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { [weak self] action in
            self?.navigationController?.dismiss(animated: true, completion: nil)
        }))
        self.navigationController?.present(alert, animated: true)
    }
    
    func alertSignInProblem() {
        let alert = UIAlertController(title: "There was a problem", message: "Details are not correct or user does not exist ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.navigationController?.present(alert, animated: true)
    }
    
    func proceedToMovieAndTvShowDetailInfo(id: Int, mediaType: String) {
        let detailInfoVC = DetailInfoViewController.instantiateFromStoryboard()
        detailInfoVC.idOfItem = id
        detailInfoVC.typeOfItem = mediaType
        detailInfoVC.coordinator = self
        navigationController?.pushViewController(detailInfoVC, animated: true)
    }
}
