//
//  MoviesViewModel.swift
//  Moviez
//
//  Created by MacBook  on 22.07.21.
//

import UIKit

struct MoviesViewModel {
    
    private var movies: Movies
    
    init(movies:Movies) {
        self.movies = movies
    }
    
    var averageRate: String? {
        String(movies.voteAverage ?? 0.0)
    }
    
    var runtime: String? {
        "Runtime \(movies.runtime ?? 0)"
    }
    
    var title: String? {
        movies.title
    }
    
    var imageURL: URL? {
        URL(string:  BaseURL.imageBaseURL + "\(movies.posterURL ?? "")")
    }
    
    var id: Int? {
        movies.id
    }
    
    var releaseDate: String? {
        String(describing: movies.releaseDate ?? "")
    }
    
    var tagline: String? {
        movies.tagline
    }
    
    var overview: String? {
        movies.overview
    }
    
}
