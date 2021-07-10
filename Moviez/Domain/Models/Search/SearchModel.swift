//
//  SearchModel.swift
//  Moviez
//
//  Created by MacBook  on 12.06.21.
//

import Foundation

struct SearchModel: Codable {
    let posterURL: String?
    let id: Int?
    let mediaType: MediaType.RawValue?
    let originalTitle: String?
    let name: String?
    let voteAverage: Double?
    let gender: Int?
    let personImage: String?
    let popularity: Double?
    let knownFor: String?
    let tvShowFirstAirDate: String?
    let movieReleaseDate: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id, name, gender, popularity
        case posterURL           = "poster_path"
        case mediaType           = "media_type"
        case originalTitle       = "original_title"
        case voteAverage         = "vote_average"
        case personImage         = "profile_path"
        case knownFor            = "known_for_department"
        case tvShowFirstAirDate  = "first_air_date"
        case movieReleaseDate    = "release_date"
        
    }
    
}
