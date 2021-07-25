//
//  PersonCredits.swift
//  Moviez
//
//  Created by MacBook  on 03.07.21.
//

import  UIKit

protocol PersonCreditsManagerProtocol: AnyObject {
    func fetchMovieCredits(with PersonId: Int, completion: @escaping ([SearchModel]) -> Void)
    func fetchTVShowCredits(with PersonId: Int, completion: @escaping ([SearchModel]) -> Void)
}

class PersonCreditsManager: PersonCreditsManagerProtocol {
    
    func fetchMovieCredits(with PersonId: Int, completion: @escaping ([SearchModel]) -> Void) {
        let url = "https://api.themoviedb.org/3/person/\(PersonId)/movie_credits?api_key=705f6a951803d1ed4524ef2a658cbc16&language=en-US"
        NetworkManager.shared.get(url: url) { (result: Result<PersonCredits, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    completion(response.cast ?? [])
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchTVShowCredits(with PersonId: Int, completion: @escaping ([SearchModel]) -> Void) {
        let url = "https://api.themoviedb.org/3/person/\(PersonId)/tv_credits?api_key=705f6a951803d1ed4524ef2a658cbc16&language=en-US"
        NetworkManager.shared.get(url: url) { (result: Result<PersonCredits, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    completion(response.cast ?? [])
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}

