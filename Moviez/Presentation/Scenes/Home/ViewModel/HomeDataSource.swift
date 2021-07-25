//
//  HomeDataSource.swift
//  Moviez
//
//  Created by MacBook  on 26.06.21.
//

import UIKit
import Firebase


class HomeDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    
    private var tableView: UITableView!
    private var viewModel: HomeViewModelProtocol!
    private var storedOffsets = [Int: CGFloat]()
    private var inTheatersList: [MoviesViewModel]?
    private var trendingMoviesList: [MoviesViewModel]?
    private var trendingTvShowList: [TvShowViewModel]?
    private var comingSoonList: [MoviesViewModel]?
    private var boxOfficeList: [BoxOfficeViewModel]?
    private var usersWatchlist: [FirebaseModel]?
    private var currentUser = Auth.auth().currentUser
    private var homeVC: HomeViewController!
    var inTheatersInfoFetched = false
    var trendingMoviesInfoFetched = false
    var trendingTvShowsInfoFetched = false
    var boxOfficeInfoFetched = false
    var comingSoonInfoFetched = false
    var usersWatchlistFetched = false 

    
    
    init(with tableView: UITableView, viewModel: HomeViewModelProtocol, homeVC: HomeViewController) {
        super.init()
        self.tableView = tableView
        self.viewModel = viewModel
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.homeVC = homeVC
    }
    
    func refresh() {
        viewModel.fetchInTheatersMovies { [weak self] inTheatersList in
            guard let self = self else {return}
            self.inTheatersList = inTheatersList
            self.inTheatersInfoFetched = true
            self.reloadFetchedData()
        }
        viewModel.fetchTrendingMovies { [weak self] trendingMoviesList in
            guard let self = self else {return}
            self.trendingMoviesList = trendingMoviesList
            self.trendingMoviesInfoFetched = true
            self.reloadFetchedData()
            
        }
        viewModel.fetchTrendingTvShows { [weak self] trendingTvShowList in
            guard let self = self else {return}
            self.trendingTvShowList = trendingTvShowList
            self.trendingTvShowsInfoFetched = true
            self.reloadFetchedData()
            
        }
        viewModel.fetchComingSoonMovies { [weak self] comingSoonList in
            guard let self = self else {return}
        
            self.comingSoonList = comingSoonList
            self.comingSoonInfoFetched = true
            self.reloadFetchedData()
        }
        viewModel.fetchBoxOfficeInfo { [weak self] boxOfficeList in
            guard let self = self else {return}
            self.boxOfficeList = boxOfficeList
            self.boxOfficeInfoFetched = true
            self.reloadFetchedData()
        }
        viewModel.fetchUsersWatchlist { [weak self] usersWatchlist in
            guard let self = self else {return}
            if self.currentUser != nil {
                self.usersWatchlist = usersWatchlist
                self.usersWatchlistFetched = true
            }
            
            
        }
    }
    
    func reloadFetchedData(){
        if inTheatersInfoFetched && trendingMoviesInfoFetched && trendingTvShowsInfoFetched && comingSoonInfoFetched && boxOfficeInfoFetched {
            self.tableView.reloadData()
            self.homeVC.view.stopLoading()
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
//            cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
            return cell
            
        case 1:
            let cell = tableView.deque(HomePageCell.self, for: indexPath)
            cell.homePageCellDelegate = self
            cell.configureTrendingTvShows(items: trendingTvShowList ?? [])
//            cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
            return cell
            
        case 2:
            if currentUser != nil {
                let cell = tableView.deque(WatchlistCell.self, for: indexPath)
                cell.configure(with: usersWatchlist)
                cell.watchlistDelegate = self
                cell.onSeeAll.addTarget(self, action: #selector(proceedToWatchlist), for: .touchUpInside)
                return cell
            } else {
                let cell = tableView.deque(SignInCell.self, for: indexPath)
                cell.buttonSignIn.addTarget(self, action: #selector(proceedToSignIn), for: .touchUpInside)
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
//            cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
            return cell
            
        case 5:
            let cell = tableView.deque(BoxOfficeCell.self, for: indexPath)
            cell.configure(with: boxOfficeList ?? [])
            return cell
            
        default:
            return cell
        }
    }
    
    //MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return currentUser != nil ? 460 : 300
        }
        if indexPath.row == 3 {
            return 290
        }
        if indexPath.row == 5 {
            return 510
        }
        if indexPath.row == 4 {return 410}
        
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
    
    @objc func proceedToSignIn() {
        viewModel.controller.coordinator?.proceedToSignUp()
    }
    
    
}

//MARK: - HomePageCell Delegate

extension HomeDataSource: HomePageCellDelegate, InTheatersCellDelegate, WatchlistCellDelegate {
    
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

