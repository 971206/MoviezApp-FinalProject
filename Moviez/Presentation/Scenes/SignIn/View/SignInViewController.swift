//
//  SignInViewController.swift
//  Moviez
//
//  Created by MacBook  on 06.06.21.
//

import UIKit
import FirebaseAuth

class SignInViewController: BaseViewController {
    
    // MARK: - Sign in Outlets
    @IBOutlet weak var labelWelcome: UILabel!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonSignup: UIButton!
    @IBOutlet weak var fieldEmail: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    @IBOutlet weak var gradientView: UIView!
    
    //MARK: - Private Properties
    private var gradientLayer = CAGradientLayer()
    private var isHidden = true
    
    // MARK: - VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
    }
    
    func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = buttonLogin.frame.size
        gradientLayer.colors =
            [UIColor(hex: "931BBD").cgColor, UIColor(hex: "FD286F").cgColor]
        buttonLogin.layer.addSublayer(gradientLayer)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonLogin.layer.cornerRadius = 8
        buttonLogin.clipsToBounds = true
    }
    
    //MARK: - Login Pressed
    @IBAction func onLogin(_ sender: Any) {
        if let email = fieldEmail.text, let password = fieldPassword.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if  error != nil {
                    self.coordinator?.alertSignInProblem()
                } else {
//                    self.coordinator?.proceedToProfile()
                    NotificationCenter.default.post(name: .signedIn, object: nil)
                }
            }
        }
    }
    
    //MARK: - IBActions
    @IBAction func onShowAndHide(_ sender: UIButton) {
        if !isHidden {
            sender.setImage(UIImage(named: "ic_show"), for: .normal)
            fieldPassword.isSecureTextEntry = true
            isHidden = true
        } else {
            sender.setImage(UIImage(named: "ic_hide"), for: .normal)
            fieldPassword.isSecureTextEntry = false
            isHidden = false
        }
    }
    
    //MARK: - Alert
//    private func problemAlert() {
//        let alert = UIAlertController(title: "There was a problem", message: "Details are not correct or user does not exist ", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
//        self.present(alert, animated: true)
//    }
//
    // MARK: - Signup Pressed
    @IBAction func onSignup(_ sender: Any) {
//        let sb = UIStoryboard(name: VCIds.registrationVC, bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: VCIds.registrationVC)
//        self.navigationController?.pushViewController(vc, animated: true)
        coordinator?.proceedToSignUp()
    }
    
}
