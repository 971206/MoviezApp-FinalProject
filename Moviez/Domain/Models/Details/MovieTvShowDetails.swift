//
//  Details.swift
//  Moviez
//
//  Created by MacBook  on 12.06.21.
//

import Foundation


struct MovieTvShowDetails: Codable {
    let id: Int?
    let mediaType: MediaType?
    let originalLanguage: String?
    let overview: String?
    let posterURL: String?
    let imageURL: String?
    let releaseDate: String?
    let voteAverage: Double?
    let totalVotes: Double?
    let nameMovie: String?
    let budget: Int?
    let revenue: Int?
    let runtime: Int?
    let tagline: String?
    let genres: [Genre]?
    let nameTvShow: String?
    let firstAirDate: String?
    let lastAirDate: String?
    let episodeRunTime: [Int]?
   // let seasons: [TvShowSeason]

    enum CodingKeys: String, CodingKey {
        case id, overview, budget, revenue, runtime, tagline, genres
        case mediaType             = "media_type"
        case originalLanguage      = "original_language"
        case posterURL             = "poster_path"
        case imageURL              = "backdrop_path"
        case releaseDate           = "release_date"
        case voteAverage           = "vote_average"
        case totalVotes            = "vote_coun"
        case nameTvShow            = "original_name"
        case nameMovie             = "title"
        case firstAirDate          = "first_air_date"
        case lastAirDate           = "last_air_date"
        case episodeRunTime        = "episode_run_time"
    }
    
    struct Genre: Codable {
        let id:  Int?
        let name: String?
    }
    
}


