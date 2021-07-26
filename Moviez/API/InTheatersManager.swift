//
//  ComingSoonManager.swift
//  Moviez
//
//  Created by MacBook  on 05.06.21.
//

import Foundation

protocol InTheatersManagerProtocol: AnyObject {
    func fetchInTheatersMovies(completion: @escaping ([Movies]) -> Void)
}

class InTheatersManager: InTheatersManagerProtocol {

    func fetchInTheatersMovies(completion: @escaping ([Movies]) -> Void) {
        let url = APIURLS.createPath(path: "/movie/now_playing")
        NetworkManager.shared.get(url: url) { (result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    completion(response.results ?? [])
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}


