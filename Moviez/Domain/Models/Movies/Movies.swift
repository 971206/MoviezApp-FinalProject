//
//  SearchModel.swift
//  Moviez
//
//  Created by MacBook  on 08.06.21.
//

import Foundation

struct Movies: Codable {
    let id: Int?
    let mediaType: MediaType.RawValue?
    let originalLanguage: String?
    let overview: String?
    let posterURL: String?
    let imageURL: String?
    let releaseDate: String?
    let voteAverage: Double?
    let totalVotes: Double?
    let title: String?
    let budget: Int?
    let revenue: Int?
    let runtime: Int?
    let tagline: String?
    let genres: [Genre]?

    enum CodingKeys: String, CodingKey {
        case id, overview, title, budget, revenue, runtime, tagline, genres
        case mediaType             = "media_type"
        case originalLanguage      = "original_language"
        case posterURL             = "poster_path"
        case imageURL              = "backdrop_path"
        case releaseDate           = "release_date"
        case voteAverage           = "vote_average"
        case totalVotes            = "vote_coun"
    }
    
    struct Genre: Codable {
        let id:  Int?
        let name: String?
    }
    
}

enum MediaType: String,Codable {
    case tv
    case movie
    case person
}

