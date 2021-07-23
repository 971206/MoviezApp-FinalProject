//
//  FirebaseModelViewModel.swift
//  Moviez
//
//  Created by MacBook  on 23.07.21.
//

import Foundation

struct FirebaseModelViewModel {
    private var firebaseModel: FirebaseModel
    init(firebaseModel: FirebaseModel) {
        self.firebaseModel = firebaseModel
    }
    
    var tvShowReleaseDate: String? {
        "\(firebaseModel.tvShowReleaseDate?.dropLast(6) ?? "" )"
    }
    
    var movieReleaseDate: String? {
        "\(firebaseModel.movieReleaseDate?.dropLast(6) ?? "" )"
    }
    
    var movieRuntime: String? {
        Double((firebaseModel.movieRuntime ?? 0) * 60).asString(style: .abbreviated)
    }
    var tvShowRuntime: String? {
        Double((firebaseModel.tvshowRuntime ?? 0) * 60).asString(style: .abbreviated)
    }
    var movieTitle: String? {
        firebaseModel.movieTitle
    }
    var tvShowTitle: String? {
        firebaseModel.tvShowTitle
    }
    var averageRate: String? {
        String(firebaseModel.averageRate ?? 0.0)
    }
    var mediaType: String? {
        firebaseModel.mediaType?.uppercased()
    }
    
    var posterURL: URL? {
         URL(string:  BaseURL.imageBaseURL + "\(firebaseModel.imageURL ?? "")")
    }
    
    var id: Int? {
        firebaseModel.id
    }
}
