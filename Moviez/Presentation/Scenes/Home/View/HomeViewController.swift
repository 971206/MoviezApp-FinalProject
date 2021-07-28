//
//  HomeViewController.swift
//  Moviez
//
//  Created by MacBook  on 05.06.21.
//

import UIKit

class HomeViewController: BaseViewController {

    // MARK: - Local Variables
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var header: UIView!
    
    private var dataSource: HomeDataSource!
    private var viewModel: HomeViewModelProtocol!
    private var inTheatersManager: InTheatersManagerProtocol!
    private var trendingMoviesManager: TrendingMoviesManagerProtocol!
    private var trendingTvShowsManager: TrendingTvShowsManagerProtocol!
    private var comingSoonManager: ComingSoonManagerProtocol!
    private var boxOfficeManager: BoxOfficeManagerProtocol!
    private var firebaseManager: FirebaseManagerProtocol!
    private var recommendedManager: RecommendedManagerProtocol!
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.startLoading()
        setupTableView()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        setupNavController()
        configureDataSource()
    }
    
    private func setupNavController() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.isNavigationBarHidden = true
    }
    
// MARK: - Configure TableView
    private func setupTableView() {
        tableView.registerNib(class: HomePageCell.self)
        tableView.registerNib(class: BoxOfficeCell.self)
        tableView.registerNib(class: InTheatersCell.self)
        tableView.registerNib(class: WatchlistCell.self)
        tableView.registerNib(class: ReminderCell.self)
        tableView.registerNib(class: RecommendationCell.self)
        tableView.registerNib(class: TitleCell.self)
        
        tableView.separatorStyle = .none
        header.layer.cornerRadius = 8
    }
    
    //MARK: - Configure DataSource
    private func configureDataSource() {
        inTheatersManager = InTheatersManager()
        trendingMoviesManager = TrendingMoviesManager()
        trendingTvShowsManager = TrendingTvShowsManager()
        comingSoonManager = ComingSoonManager()
        boxOfficeManager = BoxOfficeManager()
        firebaseManager = FirebaseManager()
        recommendedManager = RecommendedManager()
        viewModel = HomeViewModel(with: inTheatersManager,
                                  trendingMoviesManager: trendingMoviesManager,
                                  trendingTvShowsManager: trendingTvShowsManager,
                                  comingSoonManager: comingSoonManager,
                                  boxOfficeManager: boxOfficeManager,
                                  firebaseManager: firebaseManager,
                                  recommendedManager: recommendedManager,
                                  controller: self)
        dataSource = HomeDataSource(with: tableView,
                                    viewModel: viewModel, homeVC: self)
        dataSource.refresh()
    }
}



