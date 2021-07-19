//
//  TrailerViewModel.swift
//  Moviez
//
//  Created by MacBook  on 19.07.21.
//

import Foundation

protocol YoutubeVideoViewModelProtocol {
    func fetchVideos(with type: String, id: Int, completion: @escaping ([Video]) -> Void)
    
    var controller: CoordinatorDelegate {get}
    
    init(with youtubeVideoManager: YoutubeVideoManagerProtocol, controller: CoordinatorDelegate)
}

class YoutubeVideoViewModel: YoutubeVideoViewModelProtocol {

    private var youtubeVideoManager: YoutubeVideoManagerProtocol!
    private(set) var controller: CoordinatorDelegate

    required init(with youtubeVideoManager: YoutubeVideoManagerProtocol, controller: CoordinatorDelegate) {
        self.youtubeVideoManager = youtubeVideoManager
        self.controller = controller
    }
    
    func fetchVideos(with type: String, id: Int, completion: @escaping ([Video]) -> Void) {
        youtubeVideoManager.fetchVideos(with: type, id: id, completion: completion)
    }
}
