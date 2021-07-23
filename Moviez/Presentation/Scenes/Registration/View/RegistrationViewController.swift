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
    @IBOutlet weak var buttonShowAndHide: UIButton!
    @IBOutlet weak var buttonView: UIView!

    private var isHidden = true
    
    //MARK:- VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonView.setGradientBackground(colorOne: UIColor(hex: "931BBD"), colorTwo: UIColor(hex: "FD286F"))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonView.layer.cornerRadius = 8
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
//            coordinator?.alertRegistrationProblem(message: error ?? "")
        } else {
            if let email = fieldEmail.text, let password = fieldPassword.text, let fullName = fieldFullName.text {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error  {
                        self.alertProblem(message: error.localizedDescription )
//                        self.coordinator?.alertRegistrationProblem(message: error.localizedDescription)
                        self.coordinator?.alertRegistrationProblem(message: error.localizedDescription)
                        print(error.localizedDescription)
                    } else {
                        let dataBase = Firestore.firestore()
                        let uid = Auth.auth().currentUser?.uid
                        dataBase.collection("users").document(uid!).setData(["fullName" : fullName, "uid" : uid!])
                        
//                        dataBase.collection("users").addDocument(data: ["fullName" : fullName, "uid" : result!.user.uid])
                        { error in
                            if error != nil {
                                guard let error = error?.localizedDescription else {return}
//                                self.alertProblem(message: error ?? "")
                                self.coordinator?.alertRegistrationProblem(message: error)
                            }
                        }
//                        self.coordinator?.alertRegistrationSuccess()
                        self.coordinator?.alertRegistrationSuccess()
                        self.alertSuccess()
                    }
                }
            }
            
        }
        
    }
    
    
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
