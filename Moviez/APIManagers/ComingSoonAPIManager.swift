//
//  ComingSoonAPIManager.swift
//  Moviez
//
//  Created by MacBook  on 06.06.21.
//


import Foundation

protocol ComingSoonManagerProtocol: AnyObject {
    func fetchComingSoonMovies(completion: @escaping ([Movies]) -> Void)
}

class ComingSoonManager: ComingSoonManagerProtocol {

    func fetchComingSoonMovies(completion: @escaping ([Movies]) -> Void) {
        let url = APIURLS.createPath(path: "/movie/upcoming")
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
