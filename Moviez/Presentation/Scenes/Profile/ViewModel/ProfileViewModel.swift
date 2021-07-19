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
}

class ProfileViewModel: ProfileViewModelProtocol {
    let dataBase = Firestore.firestore()
    
    func fetchUsersWatchlist(completion: @escaping([FirebaseModel]) -> Void) {
        var usersWatchlistArray = [FirebaseModel]()
        dataBase.collection(Auth.auth().currentUser?.uid ?? "").whereField("collection", isEqualTo: "watchlist").getDocuments { (snapShot, error) in
            if error == nil && snapShot != nil {
                snapShot!.documents.forEach { documet in
                    let documentData = documet.data()
                    
                    var firebaseModel = FirebaseModel()
                    documentData.forEach { key,value in
                        if key == "movieTitle" { firebaseModel.movieTitle = value as? String }
                        if key == "movieReleaseDate" { firebaseModel.movieReleaseDate = value as? String }
                        if key == "mediaType" {firebaseModel.mediaType = value as? String}
                        if key == "tvShowReleaseDate" {firebaseModel.tvShowReleaseDate = value as? String}
                        if key == "tvShowTitle" {firebaseModel.tvShowTitle = value as? String}
                        if key == "imageURL" {firebaseModel.imageURL = value as? String}
                        if key == "collection" {firebaseModel.collection = value as? String}
                        if key == "averageRate" {firebaseModel.averageRate = value as? Float}
                        if key == "id" {firebaseModel.id = value as? Int}
                    }
                    usersWatchlistArray.append(firebaseModel)
                
                }
                completion(usersWatchlistArray)
            }
        }
    }
    
    func fetchUsersFavorites(completion: @escaping([FirebaseModel]) -> Void) {
        var usersFavoritesArray = [FirebaseModel]()
        dataBase.collection(Auth.auth().currentUser?.uid ?? "").whereField("collection", isEqualTo: "favorite").getDocuments { (snapShot, error) in
            if error == nil && snapShot != nil {
                snapShot!.documents.forEach { documet in
                    let documentData = documet.data()

                    var firebaseModel = FirebaseModel()
                    documentData.forEach { key,value in
                        if key == "movieTitle" { firebaseModel.movieTitle = value as? String }
                        if key == "movieReleaseDate" { firebaseModel.movieReleaseDate = value as? String }
                        if key == "mediaType" {firebaseModel.mediaType = value as? String}
                        if key == "tvShowReleaseDate" {firebaseModel.tvShowReleaseDate = value as? String}
                        if key == "tvShowTitle" {firebaseModel.tvShowTitle = value as? String}
                        if key == "imageURL" {firebaseModel.imageURL = value as? String}
                        if key == "collection" {firebaseModel.collection = value as? String}
                        if key == "averageRate" {firebaseModel.averageRate = value as? Float}
                        if key == "id" {firebaseModel.id = value as? Int}
                    }
                    usersFavoritesArray.append(firebaseModel)
                }
                completion(usersFavoritesArray)
            }
        }
        
    }

}


