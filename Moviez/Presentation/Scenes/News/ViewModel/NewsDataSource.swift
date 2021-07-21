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
    private var newsList: [Articles]?
    private var celebrityNewsList: [Articles]?
    private var moviesNewsList: [Articles]?
    private var tvShowNewsList: [Articles]?
    private var viewModel: NewsViewModelProtocol!
    private var vc: NewsViewController?
    private var awardsList: [Awards]?
    
    init(with tableView: UITableView, viewModel: NewsViewModelProtocol,vc: NewsViewController?) {
        super.init()
        self.tableView = tableView
        self.tableView.dataSource = self
        self.viewModel = viewModel
        self.tableView.delegate = self
//        self.tableView.register(UINib(nibName: "NewsCategoryHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "NewsCategoryHeader")
        self.vc = vc
    }
    
    func refresh() {
       
        viewModel.fetchAwards { [weak self] awardsList in
            self?.awardsList = awardsList
            self?.vc?.view.stopLoading()
            self?.tableView.reloadData()
        }
        
        viewModel.fetchCelebrityNews { [weak self] celebrityNewsList in
            self?.celebrityNewsList = celebrityNewsList
            self?.vc?.view.stopLoading()
            self?.tableView.reloadData()
        }
        
        viewModel.fetchMovieNews { [weak self] moviesNewsList  in
            self?.moviesNewsList = moviesNewsList
            self?.vc?.view.stopLoading()
            self?.tableView.reloadData()
        }
        viewModel.fetchTvShowNews { [weak self] tvShowsList in
            self?.tvShowNewsList = tvShowsList
            self?.vc?.view.stopLoading()
            self?.tableView.reloadData()
        }
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 4
//    }
//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 1
//        case 1:
//            return 2
//        case 2:
//            return 1
//        case 3:
//            return 1
//        default:
//            return 0
//        }
        
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
        viewModel.controller.coordinator?.proceedToMoreNews(newsList: moviesNewsList ?? [])
    }
    @objc func readMoreTvShowNews() {
        viewModel.controller.coordinator?.proceedToMoreNews(newsList: tvShowNewsList ?? [])
    }
    @objc func readMoreCelebrityNews() {
        viewModel.controller.coordinator?.proceedToMoreNews(newsList: celebrityNewsList ?? [])
    }
   
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "NewsCategoryHeader") as! NewsCategoryHeader
//        switch  section {
//        case 0:
//            header.category.text = "Movie News"
//            return header
//        case 1:
//            header.category.text = "Awards"
//            return header
//        case 2:
//            header.category.text = "Tv Show News"
//            return header
//        case 3:
//            header.category.text = "Celebrity News"
//            return header
//        default:
//            return UIView()
//        }
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 330
        case 1:
            return 326
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
    
    func onNewsCellClicked(news: Articles?) {
        guard let news = news else {return}
        viewModel.controller.coordinator?.proceetToNewsDetail(with: news)
    }
    func onCelebrityCellClicked(news: Articles?) {
        guard let news = news else {return}
        viewModel.controller.coordinator?.proceetToNewsDetail(with: news)
    }
    func onTvShowCellClicked(news: Articles?) {
        guard let news = news else {return}
        viewModel.controller.coordinator?.proceetToNewsDetail(with: news)

    }

}
