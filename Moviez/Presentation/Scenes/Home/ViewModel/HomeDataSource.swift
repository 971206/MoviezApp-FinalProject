//
//  HomeDataSource.swift
//  Moviez
//
//  Created by MacBook  on 26.06.21.
//

import UIKit

class HomeDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, HomePageCellDelegate, InTheatersCellDelegate {
    
    private var tableView: UITableView!
    private var viewModel: HomeViewModelProtocol!
    private var navigationController: UINavigationController!
    private var storedOffsets = [Int: CGFloat]()
    private var inTheatersList: [Movies]?
    private var trendingMoviesList: [Movies]?
    private var trendingTvShowList: [TvShows]?
    private var comingSoonList: [Movies]?
    
    
    init(with tableView: UITableView, viewModel: HomeViewModelProtocol, navigationController: UINavigationController) {
        super.init()
        self.tableView = tableView
        self.viewModel = viewModel
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.navigationController = navigationController
    }
    
    func refresh() {
        viewModel.fetchInTheatersMovies { [weak self] inTheatersList in
            guard let self = self else {return}
            self.inTheatersList = inTheatersList
            self.tableView.reloadData()
        }
        viewModel.fetchTrendingMovies { [weak self] trendingMoviesList in
            guard let self = self else {return}
            self.trendingMoviesList = trendingMoviesList
            self.tableView.reloadData()

        }
        viewModel.fetchTrendingTvShows { [weak self] trendingTvShowList in
            guard let self = self else {return}
            self.trendingTvShowList = trendingTvShowList
            self.tableView.reloadData()

        }
        viewModel.fetchComingSoonMovies { [weak self] comingSoonList in
            guard let self = self else {return}
            self.comingSoonList = comingSoonList
            self.tableView.reloadData()
        }
    }
    

    //MARK: - TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.row == 0 {
            let cell = tableView.deque(HomePageCell.self, for: indexPath)
            cell.homePageCellDelegate = self
            cell.configureTrendingMovies(items: trendingMoviesList ?? [])
            cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = tableView.deque(HomePageCell.self, for: indexPath)
            cell.homePageCellDelegate = self
            cell.configureTrendingTvShows(items: trendingTvShowList ?? [])
            cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.deque(InTheatersCell.self, for: indexPath)
            cell.inTheatersCellDelegate = self
            cell.configureInTheares(movies: inTheatersList ?? [])
//            cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
            return cell
        }
        
        if indexPath.row == 3 {
            let cell = tableView.deque(HomePageCell.self, for: indexPath)
            cell.homePageCellDelegate = self
            cell.configureComingSoon(items: comingSoonList ?? [])
            cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
            return cell
        }
        
        if indexPath.row == 4 {
            let cell = tableView.deque(BoxOfficeCell.self, for: indexPath)
            return cell
        }
        return cell
    }
    
    //MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return 260
        }
        return 395
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.8) {
            cell.alpha = 1
        }
        guard let cell = cell as? HomePageCell else { return }
        storedOffsets[indexPath.row] = cell.collectionViewOffset
    }
    
    //MARK: - HomePageCell Delegate
    func onTrendingMoviesClicked(movie: Movies) {
        viewModel.controller.coordinator?.onTrendingComingSoonTheatersClicked(movie: movie)
    }
    
    func onInTheatersClicked(movie: Movies) {
        viewModel.controller.coordinator?.onTrendingComingSoonTheatersClicked(movie: movie)
    }
    
    func onTrendingTvShowClicked(tvShow: TvShows) {
        viewModel.controller.coordinator?.onTrendingTvShowClicked(tvShow: tvShow)
    }
    
    func onComingSoonClicked(movie: Movies) {
        viewModel.controller.coordinator?.onTrendingComingSoonTheatersClicked(movie: movie)
    }
    
}


    

