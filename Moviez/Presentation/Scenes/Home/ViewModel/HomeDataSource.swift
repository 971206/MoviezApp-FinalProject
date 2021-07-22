//
//  HomeDataSource.swift
//  Moviez
//
//  Created by MacBook  on 26.06.21.
//

import UIKit
import Firebase


class HomeDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, HomePageCellDelegate, InTheatersCellDelegate, WatchlistCellDelegate {


    private var tableView: UITableView!
    private var viewModel: HomeViewModelProtocol!
    private var navigationController: UINavigationController!
    private var storedOffsets = [Int: CGFloat]()
    private var inTheatersList: [MoviesViewModel]?
    private var trendingMoviesList: [MoviesViewModel]?
    private var trendingTvShowList: [TvShowViewModel]?
    private var comingSoonList: [MoviesViewModel]?
    
    
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
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            let cell = tableView.deque(HomePageCell.self, for: indexPath)
            cell.homePageCellDelegate = self
            cell.configureTrendingMovies(items: trendingMoviesList ?? [])
            cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
            return cell
            
        case 1:
            let cell = tableView.deque(HomePageCell.self, for: indexPath)
            cell.homePageCellDelegate = self
            cell.configureTrendingTvShows(items: trendingTvShowList ?? [])
            cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
            return cell
            
        case 2:
            if Auth.auth().currentUser != nil {
                let cell = tableView.deque(WatchlistCell.self, for: indexPath)
                cell.configure()
                cell.watchlistDelegate = self
                cell.onSeeAll.addTarget(self, action: #selector(proceedToWatchlist), for: .touchUpInside)
                return cell
            } else {
                let cell = tableView.deque(EmptyCell.self, for: indexPath)
                return cell
            }
            
        case 3:
            let cell = tableView.deque(InTheatersCell.self, for: indexPath)
            cell.inTheatersCellDelegate = self
            cell.configureInTheares(movies: inTheatersList ?? [])
            return cell
            
        case 4:
            let cell = tableView.deque(HomePageCell.self, for: indexPath)
            cell.homePageCellDelegate = self
            cell.configureComingSoon(items: comingSoonList ?? [])
            cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
            return cell
            
        case 5:
            let cell = tableView.deque(BoxOfficeCell.self, for: indexPath)
            return cell
            
        default:
            return cell
        }
    }
    
    //MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return 260
        }
        if indexPath.row == 2 {
            return 453
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
    
    @objc func proceedToWatchlist() {
        print("vc here")
    }
    
    
    //MARK: - HomePageCell Delegate
    func onTrendingMoviesClicked(movie: MoviesViewModel) {
        viewModel.controller.coordinator?.onTrendingComingSoonTheatersClicked(movie: movie)
    }
    
    func onInTheatersClicked(movie: MoviesViewModel) {
        viewModel.controller.coordinator?.onTrendingComingSoonTheatersClicked(movie: movie)
    }
    
    func onTrendingTvShowClicked(tvShow: TvShowViewModel) {
        viewModel.controller.coordinator?.onTrendingTvShowClicked(tvShow: tvShow)
    }
    
    func onComingSoonClicked(movie: MoviesViewModel) {
        viewModel.controller.coordinator?.onTrendingComingSoonTheatersClicked(movie: movie)
    }
    
    func onWatchlisClicked(id: Int, mediaType: String) {
        viewModel.controller.coordinator?.proceedToMovieAndTvShowDetailInfo(id: id, mediaType: mediaType)
    }
    
 
    

}


    

