//
//  VideoAPIManager.swift
//  Moviez
//
//  Created by MacBook  on 26.06.21.
//

import Foundation

protocol YoutubeVideoManagerProtocol: AnyObject {
    func fetchVideos(with type: String, id: Int, completion: @escaping ([Video]) -> Void)
}

class YoutubeVideoManager: YoutubeVideoManagerProtocol {
    func fetchVideos(with type: String, id: Int, completion: @escaping ([Video]) -> Void) {
        let link = "https://api.themoviedb.org/3/\(type)/\(id)/videos?api_key=705f6a951803d1ed4524ef2a658cbc16&language=en-US"
        NetworkManager.shared.get(url: link) { (result: Result<VideoResponse, Error>) in
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
