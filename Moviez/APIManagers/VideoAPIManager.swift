//
//  VideoAPIManager.swift
//  Moviez
//
//  Created by MacBook  on 26.06.21.
//

import Foundation

protocol VideoManagerProtocol: AnyObject {
    func fetchVideos(with type: String, id: Int, completion: @escaping ([Video]) -> Void)
}

class VideoManager: VideoManagerProtocol {
    func fetchVideos(with type: String, id: Int, completion: @escaping ([Video]) -> Void) {
        let link = APIURLS.createPath(path: "\(type)/\(id)videos")
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
