//
//  TrendingTvShows.swift
//  Moviez
//
//  Created by MacBook  on 06.06.21.
//

import Foundation

struct TvShows: Codable {
    let imageURL: String?
    let episodeRuntime: [Int]?
    let mediaType: MediaType?
    let firstAirDate: String?
    let id: Int?
    let name: String?
    let originalLanguage: String?
    let overview: String?
    let posterURL: String?
    let voteAverage: Float?
    let totalVotes: Int?
    let lastAirDate: String?
    let tagline: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, overview, tagline
        case imageURL                     = "backdrop_path"
        case firstAirDate                 = "first_air_date"
        case originalLanguage             = "original_language"
        case posterURL                    = "poster_path"
        case voteAverage                  = "vote_average"
        case totalVotes                   = "vote_count"
        case mediaType                    = "media_type"
        case episodeRuntime               = "episode_run_time"
        case lastAirDate                  = "last_air_date"
    }
    
    
}
