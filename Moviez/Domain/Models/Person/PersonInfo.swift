//
//  Person.swift
//  Moviez
//
//  Created by MacBook  on 26.06.21.
//

import Foundation

struct PersonInfo: Codable {
    let biography: String?
    let birthday: String?
    let deathday: String?
    let gender: Int?
    let knownFor: String?
    let name: String?
    let birthPlace: String?
    let imageProfile: String?
    let character: String?
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case biography, birthday, deathday, gender, name, character, id
        case knownFor       = "known_for_department"
        case birthPlace      = "place_of_birth"
        case imageProfile   = "profile_path"
    }
}
