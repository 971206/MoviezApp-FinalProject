//
//  TvShowViewModel.swift
//  Moviez
//
//  Created by MacBook  on 22.07.21.
//

import Foundation

struct TvShowViewModel {
    
    private var tvShow: TvShows
    
    init(tvShow : TvShows) {
        self.tvShow = tvShow
    }
    
    var averageRate: String? {
        String(describing: tvShow.voteAverage ?? 0)
    }
    

    var title: String? {
        tvShow.name
    }
    
    var imageURL: URL? {
        URL(string:  BaseURL.imageBaseURL + "\(tvShow.posterURL ?? "")")
    }
    
    var id: Int? {
        tvShow.id
    }
    
    var releaseDate: String? {
        String(describing: tvShow.firstAirDate ?? "")
    }
    
}
