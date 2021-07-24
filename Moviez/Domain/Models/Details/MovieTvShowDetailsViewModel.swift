//
//  PersonViewModel.swift
//  Moviez
//
//  Created by MacBook  on 23.07.21.
//

import Foundation

struct MovieTvShowDetailsViewModel {
    
    var details: MovieTvShowDetails
    init(details: MovieTvShowDetails) {
        self.details = details
    }
   
    var tvShowTitle: String? {
        details.nameTvShow
    }
    var movieTitle: String? {
        details.nameMovie
    }
    var releaseDate: String? {
        "\(details.releaseDate?.dropLast(6) ?? details.firstAirDate?.dropLast(6) ?? "")"
    }
    
    var movieReleaseDate: String? {
        "\(details.releaseDate?.dropLast(6) ?? "")"
    }
    
    var tvShowReleaseDate: String? {
     "\(details.firstAirDate?.dropLast(6) ?? "")"
    }

    var runtime: String? {
        Double((details.runtime ?? details.episodeRunTime?.first ?? 0) * 60).asString(style: .abbreviated)
    }
    
    var movieRuntime: String? {
        Double((details.runtime ?? 0) * 60).asString(style: .abbreviated)
        
    }
    
    var tvShowEpisodeRuntime: String? {
        String(details.episodeRunTime?.first ?? 0)
    }
    var tagline: String? {
        details.tagline
    }
    var averageVote: String? {
        String(describing: details.voteAverage ?? 0)
    }
    var overview: String? {
        details.overview
    }
    var imageURL: String? {
        details.posterURL
    }
    var id: Int? {
        details.id
    }
    
    var mediaType: MediaType? {
        details.mediaType
    }
    
    var seasons: [TvShowSeason]?
}
