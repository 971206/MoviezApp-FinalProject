//
//  ProfileViewModel.swift
//  Moviez
//
//  Created by MacBook  on 18.07.21.
//

import UIKit
import Firebase

protocol ProfileViewModelProtocol {
    func fetchUsersWatchlist(completion: @escaping([FirebaseModel]) -> Void)
    func fetchUsersFavorites(completion: @escaping([FirebaseModel]) -> Void)
    
    init(with firebaseManager: FirebaseManagerProtocol)
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    private var firebaseManager: FirebaseManagerProtocol
    
    
    required init(with firebaseManager: FirebaseManagerProtocol) {
        self.firebaseManager = firebaseManager
    }
 
    func fetchUsersFavorites(completion: @escaping ([FirebaseModel]) -> Void) {
        firebaseManager.fetchUsersFavorites(completion: completion)
    }
 
    
    
    func fetchUsersWatchlist(completion: @escaping ([FirebaseModel]) -> Void) {
        firebaseManager.fetchUsersWatchlist(completion: completion)
    }
    
    

}


