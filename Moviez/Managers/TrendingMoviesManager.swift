//
//  TrendingMoviesAPIManager.swift
//  Moviez
//
//  Created by MacBook  on 06.06.21.
//

import Foundation

protocol TrendingMoviesManagerProtocol: AnyObject {
    func fetchTrendingMovies(completion: @escaping([Movies]) -> Void)
}

class TrendingMoviesManager: TrendingMoviesManagerProtocol {
    func fetchTrendingMovies(completion: @escaping([Movies]) -> Void)
 {
        let url = APIURLS.createPath(path: "/movie/popular")
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
