//
//  NewsDataSource.swift
//  Moviez
//
//  Created by MacBook  on 13.06.21.
//

import UIKit

class NewsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    //MARK: - Private Properties
    private var tableView: UITableView!
    private var newsList: [ArticleViewModel]?
    private var celebrityNewsList: [ArticleViewModel]?
    private var moviesNewsList: [ArticleViewModel]?
    private var tvShowNewsList: [ArticleViewModel]?
    private var viewModel: NewsViewModelProtocol!
    private var vc: NewsViewController?
    private var awardsList: [Awards]?
    
    init(with tableView: UITableView, viewModel: NewsViewModelProtocol,vc: NewsViewController?) {
        super.init()
        self.tableView = tableView
        self.tableView.dataSource = self
        self.viewModel = viewModel
        self.tableView.delegate = self
        self.vc = vc
    }
    
    func refresh() {
       
        viewModel.fetchAwards { [weak self] awardsList in
            self?.awardsList = awardsList
            self?.vc?.view.stopLoading()
            self?.tableView.reloadData()
        }
        
        viewModel.fetchCelebrityNews(page:1) { [weak self] celebrityNewsList in
            self?.celebrityNewsList = celebrityNewsList
            self?.vc?.view.stopLoading()
            self?.tableView.reloadData()
        }
        
        viewModel.fetchMovieNews(page: 1) { [weak self] moviesNewsList  in
            self?.moviesNewsList = moviesNewsList
            self?.vc?.view.stopLoading()
            self?.tableView.reloadData()
        }
        viewModel.fetchTvShowNews(page: 1) { [weak self] tvShowsList in
            self?.tvShowNewsList = tvShowsList
            self?.vc?.view.stopLoading()
            self?.tableView.reloadData()
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.deque(MoviesCell.self, for: indexPath)
            cell.configure(with: moviesNewsList)
            cell.movieNewsCellDelegate = self
            cell.onReadMore.addTarget(self, action: #selector(readMoreMoviwNews), for: .touchUpInside)
            return cell
        case 1:
            let cell = tableView.deque(TvShowCell.self, for: indexPath)
            cell.configure(with: tvShowNewsList)
            cell.tvShowCellDelegate = self
            cell.onReadMore.addTarget(self, action: #selector(readMoreTvShowNews), for: .touchUpInside)
            return cell
        case 2:
            let cell = tableView.deque(AwardsCell.self, for: indexPath)
            cell.configure(with: awardsList)
            return cell
        case 3:
            let cell = tableView.deque(CelebrityCell.self, for: indexPath)
            cell.configure(with: celebrityNewsList)
            cell.celebrityCellDelegate = self
            cell.onReadMore.addTarget(self, action: #selector(readMoreCelebrityNews), for: .touchUpInside)
            return cell
        default:
            return .init()
        }
    }
    
    @objc func readMoreMoviwNews() {
        viewModel.controller.coordinator?.proceedToMoreNews(category: Categories.movie.rawValue)
    }
    @objc func readMoreTvShowNews() {
        viewModel.controller.coordinator?.proceedToMoreNews(category: Categories.show.rawValue)
    }
    @objc func readMoreCelebrityNews() {
        viewModel.controller.coordinator?.proceedToMoreNews(category: Categories.celebrity.rawValue)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 330
        case 1:
            return 350
        case 2:
            return 690
        case 3:
            return 306
        default:
            return .init()
        }
    }
}

extension NewsDataSource: MovieNewsCellDelegate, CelebrityCellDelegate, TvShowCellDelegate {
    
    func onNewsCellClicked(news: ArticleViewModel?) {
        guard let news = news else {return}
        viewModel.controller.coordinator?.proceetToNewsDetail(with: news)
    }
    func onCelebrityCellClicked(news: ArticleViewModel?) {
        guard let news = news else {return}
        viewModel.controller.coordinator?.proceetToNewsDetail(with: news)
    }
    func onTvShowCellClicked(news: ArticleViewModel?) {
        guard let news = news else {return}
        viewModel.controller.coordinator?.proceetToNewsDetail(with: news)

    }

}
