//
//  TrendingTvShowsAPIManager.swift
//  Moviez
//
//  Created by MacBook  on 06.06.21.
//

import Foundation

protocol TrendingTvShowsManagerProtocol: AnyObject {
    func fetchTrendingTvShows(completion: @escaping([TvShows]) -> Void)
}

class TrendingTvShowsManager: TrendingTvShowsManagerProtocol {
    func fetchTrendingTvShows(completion: @escaping([TvShows]) -> Void) {
        let url = APIURLS.createPath(path: "/tv/popular")
        NetworkManager.shared.get(url: url) { (result: Result<TvShowsResponse, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    completion(response.results!)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
