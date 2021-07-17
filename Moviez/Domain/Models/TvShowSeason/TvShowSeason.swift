//
//  TvShowSeason.swift
//  Moviez
//
//  Created by MacBook  on 15.07.21.
//

import Foundation

struct TvShowSeason: Codable {
    
    let id: Int?
    let releaseDate: String?
    let seasonName: String?
    let overview: String?
    let posterUrl: String?
    let seasonNumber: Int?
    let episodes: [Episode]?
    
    enum CodingKeys: String, CodingKey {
        case overview, id, episodes
        case seasonName = "name"
        case releaseDate = "air_date"
        case posterUrl = "poster_path"
        case seasonNumber = "season_number"
    }
    
    
}

struct Episode: Codable {
    let releaseDate: String?
    let episodeNumber: Int?
    let id: Int?
    let episodeName: String?
    let overview: String?
    let seasonNumber: String?
    let posterUrl: String?
    let voteAverage: Double?
    
    
    enum CodingKeys: String, CodingKey {
        case overview, id
        case episodeName = "name"
        case releaseDate = "air_date"
        case posterUrl = "still_path"
        case episodeNumber = "episode_number"
        case seasonNumber = "season_number"
        case voteAverage = "vote_average"
    }
}
