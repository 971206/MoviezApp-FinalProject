//
//  SearchViewModel.swift
//  Moviez
//
//  Created by MacBook  on 23.07.21.
//

import Foundation

struct SearchViewModel {
    var search: SearchModel
    init(search: SearchModel) {
        self.search = search
    }
    
    var tvShowTitle: String? {
        search.name
    }
    
    var movieTitle: String? {
        search.originalTitle
    }
    
    var title: String? 
    
    var averageRate: String? {
        String(search.voteAverage ?? 0 )
    }
    
    var posterURL: URL? {
        URL(string:  BaseURL.imageBaseURL + "\(search.posterURL ?? "")")
    }
    
    var mediaType: String?
    
    var movieReleaseDate: String? {
        search.movieReleaseDate
    }
    var tvShowReleaseDate: String? {
        search.tvShowFirstAirDate
    }
    var knownFor: String? {
        search.knownFor
    }
    
    var personImageURL: URL? {
        URL(string:  BaseURL.imageBaseURL + "\(search.personImage ?? "")")
    }
    
    var id: Int? {
        search.id
    }
    
    var popularity: String? {
        String(describing: search.popularity ?? 0)
    }
    
    var imageURLS: URL? {
        URL(string:  BaseURL.imageBaseURL + "\(search.posterURL ?? search.personImage ?? "")")
    }
    
}
