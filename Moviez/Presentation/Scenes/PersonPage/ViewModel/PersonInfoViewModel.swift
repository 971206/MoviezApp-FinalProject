//
//  PersonInfoViewModel.swift
//  Moviez
//
//  Created by MacBook  on 23.07.21.
//

import Foundation

struct PersonInfoViewModel {
    
    var personInfo: PersonInfo
    init(with personInfo: PersonInfo) {
        self.personInfo = personInfo
    }
    
    var posterURL: String? {
//        URL(string:  BaseURL.imageBaseURL + "\(personInfo.imageProfile ?? "")")
     personInfo.imageProfile 
    }
    
    var name: String? {
        personInfo.name
    }
    
    var female: String? {
        "Gender - Female"
    }
    
    var male: String? {
        "Gender - Male"
    }
    
    var birthday: String? {
        "\(personInfo.birthday ?? "") - \(personInfo.deathday ?? "")"
    }
    
    var bornPlace: String? {
        "Born in \(personInfo.birthPlace ?? "")"
    }
    
    var knownFor: String? {
        "Known for \(personInfo.knownFor ?? "")"
    }
    
    var biography: String? {
        personInfo.biography
    }
    
    var gender: Int? {
        personInfo.gender
    }
    
    
    
}
