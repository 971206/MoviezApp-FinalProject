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
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.cornerRadius = 8
        gradientView.layer.cornerRadius = 8
        gradientView.clipsToBounds = true
        gradientView.setGradientBackground(colorOne: UIColor(hex: "931BBD"), colorTwo: UIColor(hex: "FD286F"))
    }
    
    //MARK: - Login Pressed
    @IBAction func onLogin(_ sender: Any) {
        if let email = fieldEmail.text, let password = fieldPassword.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if  error != nil {
                    self.coordinator?.alertSignInProblem()
                } else {
                    UserDefaults.standard.setValue(true, forKey:"is_logged_in")
                    let sb = UIStoryboard(name: VCIds.profile, bundle: nil)
                    let vc = sb.instantiateViewController(withIdentifier: VCIds.profile)
                    self.navigationController?.pushViewController(vc, animated: true)
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
        coordinator?.proceedToSignUp()
    }
    
}
