//
//  TrailerViewController.swift
//  Moviez
//
//  Created by MacBook  on 19.07.21.
//

import UIKit
import YouTubeiOSPlayerHelper


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
        setupTabGesture()
        
    }
    
    private func setupTabGesture() {
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.view.addGestureRecognizer(tapgesture)
    }
    
    @objc func tapped() {
        UIView.animate(withDuration: 0.8) {
            self.view.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentWithAnimation()
    }
    
    private func presentWithAnimation() {
        UIView.animate(withDuration: 0.8) {
            self.view.alpha = 1
            self.playerView.isHidden = false
        } completion: { completed in
            self.view.backgroundColor = UIColor(r: 0, g: 0, b: 0, alpha: 0.8)
            self.configureViewModel()
        }
        
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
    
    private func playTrailer(with videoID: String) {
        playerView.load(withVideoId: videoID, playerVars: ["playsinline" : 1])
    }
    
    
}

extension YoutubeVideoViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
