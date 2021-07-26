//
//  FirebaseHelper.swift
//  Moviez
//
//  Created by MacBook  on 24.07.21.
//

import UIKit
import Firebase
import FirebaseAuth

class FirebaseHelper {
    
    let firebaseAuth = Auth.auth()
    let currentUser = Auth.auth().currentUser
    let currentUserID = Auth.auth().currentUser?.uid
    let database = Firestore.firestore()
    
    
    //MARK: - Sign up
    
    static func signUp(email: String, password: String, fullName: String, completion: @escaping(Bool) -> Void) {
         let firebaseAuth = Auth.auth()
         let database = Firestore.firestore()
         let currentUserID = Auth.auth().currentUser?.uid
        
         firebaseAuth.createUser(withEmail: email, password: password) { result, error in
             if error != nil {
                 completion(false)
             } else {
                 database.collection("users").document(currentUserID ?? "").setData(["fullName" : fullName, "uid" : currentUserID ?? ""]) { error in
                     if error != nil {
                         completion(false)
                     } else {
                        completion(true)
                     }
                 }
             }
         }
     }

    //MARK: - Log in
    
    static func logIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        let firebaseAuth = Auth.auth()
        firebaseAuth.signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
     
    //MARK: - Sign Out
    
    static func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            NotificationCenter.default.post(name: .signedOut, object: nil)
        } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            
        }
    }
    
    //MARK: - Save items in collection
    
    static func saveItemInFirebaseCollection(collection: String, id:Int, mediaType: String, movieRuntime: String, tvshowRuntime: String, imageURL: String, movieReleaseDate: String, tvShowReleaseDate: String, averageRate: String, movieTitle: String, tvShowTitle: String, completion: @escaping () -> Void) {
        let currentUserID = Auth.auth().currentUser?.uid
        let database = Firestore.firestore()
        database.collection("users").document(currentUserID ?? "").collection(collection).document(String(id)).setData(["id" : id, "mediaType" : mediaType, "movieRuntime": movieRuntime, "tvshowRuntime": tvshowRuntime, "imageURL" : imageURL, "movieReleaseDate" : movieReleaseDate, "tvShowReleaseDate" : tvShowReleaseDate, "averageRate" : averageRate, "movieTitle" : movieTitle, "tvShowTitle" : tvShowTitle
        ]) { error in
            if error == nil {
                completion()
            }
        }
    }
    
    //MARK: - Delete items in collection
    
    static func deleteSavedItems(id : String, collection: String) {
        let currentUser = Auth.auth().currentUser
        let currentUserID = Auth.auth().currentUser?.uid
        if currentUser != nil {
            guard let currentUserID = currentUserID else {return}
            Firestore.firestore().collection("users").document(currentUserID).collection(collection).document(id).delete()
        }
    }
    
    //MARK: - Check if item is saved in collection
    
    static func checkIfItemIsInCollection(id: Int, collection: String, completion: @escaping (Bool) -> Void) {
        let database = Firestore.firestore()
        let currentUserID = Auth.auth().currentUser?.uid
        database.collection("users").document(currentUserID ?? "").collection(collection).document("\(id)").getDocument { document, error in
            if error == nil {
                if document != nil && document!.exists {
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
    

//    func signUp(email: String, password: String, fullName: String, completion: @escaping() -> Void) {
//        var succeedRegistration = false
//        firebaseAuth.createUser(withEmail: email, password: password) { result, error in
//            if error != nil {
//                succeedRegistration = false
//            } else {
//                Firestore.firestore().collection("users").document(self.currentUserID ?? "").setData(["fullName" : fullName, "uid" : self.currentUserID ?? ""])
//                succeedRegistration = true
//            }
//        }
//
//        return succeedRegistration
//    }
//
    

   
    
  
}
