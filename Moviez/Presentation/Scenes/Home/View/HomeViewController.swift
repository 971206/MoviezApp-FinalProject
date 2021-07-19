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

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavController()
    }
    
    private func setupNavController() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
          navigationController?.navigationBar.shadowImage = UIImage()
          navigationController?.navigationBar.isTranslucent = true
        navigationController?.isNavigationBarHidden = true
    }
    
// MARK: - Configure TableView
    private func configureTableView() {
        tableView.registerNib(class: HomePageCell.self)
        tableView.registerNib(class: BoxOfficeCell.self)
        tableView.registerNib(class: InTheatersCell.self)
        tableView.separatorStyle = .none
        header.layer.cornerRadius = 8
    }
    
    private func configureDataSource() {
        inTheatersManager = InTheatersManager()
        trendingMoviesManager = TrendingMoviesManager()
        trendingTvShowsManager = TrendingTvShowsManager()
        comingSoonManager = ComingSoonManager()
        viewModel = HomeViewModel(with: inTheatersManager,
                                  trendingMoviesManager: trendingMoviesManager,
                                  trendingTvShowsManager: trendingTvShowsManager,
                                  comingSoonManager: comingSoonManager,
                                  controller: self)
        dataSource = HomeDataSource(with: tableView,
                                    viewModel: viewModel,
                                    navigationController: navigationController!)
        dataSource.refresh()
    }
}



