//
//  FirebaseManager.swift
//  Moviez
//
//  Created by MacBook  on 23.07.21.
//

import Foundation
import Firebase

protocol FirebaseManagerProtocol {
    func fetchFavorites(completion: @escaping([FirebaseModel]) -> Void)
}

class FirebaseManager: FirebaseManagerProtocol {
    func fetchFavorites(completion: @escaping([FirebaseModel]) -> Void) {
        var usersFavoritesArray = [FirebaseModel]()
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}

       Firestore.firestore().collection(currentUserID).whereField("collection", isEqualTo: "favorites").getDocuments { (snapShot, error) in
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
                        if key == "movieRuntime" {firebaseModel.movieRuntime = value as? Int}
                        if key == "tvshowRuntime" {firebaseModel.tvshowRuntime = value as? Int}
                    }
                    usersFavoritesArray.append(firebaseModel)
                }
                completion(usersFavoritesArray)
            }
        }
    }
    
    
}
