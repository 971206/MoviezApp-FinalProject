//
//  TrailerViewController.swift
//  Moviez
//
//  Created by MacBook  on 19.07.21.
//

import UIKit


class YoutubeVideoViewController: BaseViewController {
    
 
    private var youtubeVideoManager: YoutubeVideoManagerProtocol!
    private var viewModel: YoutubeVideoViewModelProtocol!
    var videoItem: [Video]?
    var mediaType: String?
    var itemID: Int?
    
    @IBOutlet weak var playerView: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        configureViewModel()
    }
    
    
    private func playTrailer(with videoID: String) {
        playerView.load(withVideoId: videoID, playerVars: ["playsinline" : 1])
    }
    
    func configureViewModel() {
        youtubeVideoManager = YoutubeVideoManager()
        viewModel = YoutubeVideoViewModel(with: youtubeVideoManager, controller: self)
        viewModel.fetchVideos(with: mediaType ?? "", id: itemID ?? 0) { [weak self] videoItem in
            self?.videoItem = videoItem
            DispatchQueue.main.async {
                self?.playTrailer(with: videoItem.first?.key ?? "")
            }
        }
    }
    
}

extension YoutubeVideoViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
