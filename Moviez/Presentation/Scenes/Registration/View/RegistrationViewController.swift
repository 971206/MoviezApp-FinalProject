//
//  RegistrationViewController.swift
//  Moviez
//
//  Created by MacBook  on 05.06.21.
//

import UIKit
import FirebaseAuth
import Firebase

class RegistrationViewController: BaseViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var labelCreateAccount: UILabel!
    @IBOutlet weak var fieldFullName: UITextField!
    @IBOutlet weak var fieldEmail: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    @IBOutlet weak var buttonRegistration: UIButton!
    
    
    //MARK:- VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRegistrationButton()
    }
    
    func configureRegistrationButton() {
        buttonRegistration.setGradientBackground(colorOne: UIColor(hex: "931BBD"), colorTwo: UIColor(hex: "FD286F"))
        buttonRegistration.layer.masksToBounds = true
        buttonRegistration.layer.cornerRadius = 8
    }
    
    //MARK: - Check Fields
    private func validateFields() -> String? {
        if fieldFullName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            fieldEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            fieldPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please, fill in all fields."
        }
        return nil
    }
    
    //MARK: - IBActions
    @IBAction func onCreateAccount(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            alertProblem(message: error ?? "")
            self.coordinator?.alertRegistrationProblem(message: error ?? "")
            
        } else {
            if let email = fieldEmail.text, let password = fieldPassword.text, let fullName = fieldFullName.text {
                FirebaseHelper.signUp(email: email, password: password, fullName: fullName) { completed in
                    if completed {
                        //                        self.coordinator?.alertRegistrationSuccess()
                        self.alertSuccess()
                    } else {
                        self.alertProblem(message: "problem")
                    }
                }
            }
        }
        
    }
    
    //MARK: - Alerts
    private func alertProblem(message: String) {
        let alert = UIAlertController(title: "There was a problem", message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func alertSuccess() {
        let alert = UIAlertController(title: "Congratulations!", message: "User has successfully been registered! Now you can sign in." , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
    }
}
