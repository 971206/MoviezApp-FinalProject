//
//  MoreNewsDataSource.swift
//  Moviez
//
//  Created by MacBook  on 21.07.21.
//

import Foundation
import UIKit
//import  AVKit


class MoreNewsDataSource: NSObject {
    private var tableView: UITableView!
    
    private var controller: CoordinatorDelegate?
    private var vc: UIViewController?
    private var viewModel: MoreNewsViewModelProtcol!
    
    private var celebrityNewsList: [ArticleViewModel]?
    private var moviesNewsList: [ArticleViewModel]?
    private var tvShowNewsList: [ArticleViewModel]?
    
    private var isFetchigMoreData = false
    private var isPagingDone = false
    private var pageSize = 20
    private var page = 1
    
     var newsList: [ArticleViewModel]?
    
    init(with tableView: UITableView, viewModel: MoreNewsViewModelProtcol, controller: CoordinatorDelegate, vc: UIViewController) {
        super.init()
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.viewModel = viewModel
        self.controller = controller
    }

    func fetchCelebrityNews() {
        viewModel.fetchCelebrityNews(page: 1) { [weak self] celebrityNews in
            self?.celebrityNewsList = celebrityNews
            self?.tableView.reloadData()
        }
    }
    
    func fetchMoreCelebrityNews() {
        guard isPagingDone == false && isFetchigMoreData == false else { return }
        isFetchigMoreData = true
        page += 1
        viewModel.fetchCelebrityNews(page: page) { [weak self] celebrityNews in
            guard let self = self else {return}
            self.celebrityNewsList?.append(contentsOf: celebrityNews)
            self.isPagingDone = celebrityNews.count != self.pageSize
            self.isFetchigMoreData = false
            self.tableView.reloadData()
        }
    }
    
    func fetchMovieNews() {
        viewModel.fetchMovieNews(page: 1) { [weak self] movieNews in
            self?.moviesNewsList = movieNews
            self?.tableView.reloadData()
        }
    }
    
    func fetchMoreMovieNews() {
        guard isPagingDone == false && isFetchigMoreData == false else { return }
        isFetchigMoreData = true
        page += 1
        viewModel.fetchMovieNews(page: page) { [weak self] movieNews in
            guard let self = self else {return}
            self.moviesNewsList?.append(contentsOf: movieNews)
            self.isPagingDone = movieNews.count != self.pageSize
            self.isFetchigMoreData = false
            self.tableView.reloadData()
        }
    }
    
    
    func fetchTvShowNews() {
        viewModel.fetchTvShowNews(page: 1) { [weak self] tvShowNews in
            self?.tvShowNewsList = tvShowNews
            self?.tableView.reloadData()
        }
    }
    
    func fetchMoreTvShowNews() {
        guard isPagingDone == false && isFetchigMoreData == false else { return }
        isFetchigMoreData = true
        page += 1
        viewModel.fetchTvShowNews(page: page) { [weak self] tvShowNews in
            guard let self = self else {return}
            self.tvShowNewsList?.append(contentsOf: tvShowNews)
            self.isPagingDone = tvShowNews.count != self.pageSize
            self.isFetchigMoreData = false
            self.tableView.reloadData()
        }
    }
    
}

extension MoreNewsDataSource: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let item = celebrityNewsList {return item.count}
        if let item = moviesNewsList {return item.count}
        if let item = tvShowNewsList {return item.count}
        return .init()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(NewsCell.self, for: indexPath)
        if let celebrityNews = celebrityNewsList?[indexPath.row] {
            cell.configure(with: celebrityNews)
            if indexPath.row == (celebrityNewsList?.count ?? 0) - 1 {
                fetchMoreCelebrityNews()
            }
        }
        
        if let movieNews = moviesNewsList?[indexPath.row] {
            cell.configure(with: movieNews)
            if indexPath.row == (moviesNewsList?.count ?? 0) - 1 {
                fetchMoreMovieNews()
            }
        }
        
        if let tvShowNews = tvShowNewsList?[indexPath.row] {
            cell.configure(with: tvShowNews)
            if indexPath.row == (tvShowNewsList?.count ?? 0) - 1 {
                fetchMoreTvShowNews()
            }
        }
        return cell
    }
    
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieNews = moviesNewsList?[indexPath.row] {
            controller?.coordinator?.proceetToNewsDetail(with: movieNews)
        }
        if let tvShowNews = tvShowNewsList?[indexPath.row] {
            controller?.coordinator?.proceetToNewsDetail(with: tvShowNews)
        }
        if let celebrityNews = celebrityNewsList?[indexPath.row] {
            controller?.coordinator?.proceetToNewsDetail(with: celebrityNews)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -15, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.7) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
}

extension MoreNewsDataSource: NewsCellDelegate {
    func shareNews(cell: NewsCell) {
        if let indexPath = tableView?.indexPath(for: cell) {
            let link = newsList?[indexPath.row].sourceURL
            let objectsToShare = [link]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            vc?.present(activityVC, animated: true)
        }
    }
}
