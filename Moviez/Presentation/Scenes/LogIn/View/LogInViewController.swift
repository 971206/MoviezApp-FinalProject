//
//  SignInViewController.swift
//  Moviez
//
//  Created by MacBook  on 06.06.21.
//

import UIKit
import FirebaseAuth

class LogInViewController: BaseViewController {
    
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
        configureButtonLogin()
    }
    
    func configureButtonLogin() {
        buttonLogin.setGradientBackground(colorOne: UIColor(hex: "931BBD"), colorTwo: UIColor(hex: "FD286F"))
        buttonLogin.layer.masksToBounds = true
        buttonLogin.layer.cornerRadius = 8
    }

    
    //MARK: - Login Pressed
    @IBAction func onLogin(_ sender: Any) {
        if let email = fieldEmail.text, let password = fieldPassword.text {
            FirebaseHelper.logIn(email: email, password: password) { success in
                if success {
                    self.fieldEmail.text = ""
                    self.fieldPassword.text = ""
                    NotificationCenter.default.post(name: .signedIn, object: nil)
                } else {
                    self.coordinator?.alertLogInProblem()
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
    
    // MARK: - Signup Pressed
    @IBAction func onSignup(_ sender: Any) {
        coordinator?.proceedToSignUp()
    }
    
}
