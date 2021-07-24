//
//  NewsViewController.swift
//  Moviez
//
//  Created by MacBook  on 13.06.21.
//

import UIKit

class NewsViewController: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Private Properties
    private var dataSource: NewsDataSource!
    private var viewModel: NewsViewModelProtocol!
    private var newsManager: NewsManagerProtocol!
    private var awardsManager: AwardsManagerProtocol!
    
    //MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "News"
        self.view.startLoading()
        setUpTableView()
        configureViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = UIColor(named: "lightBackground")
        navigationController?.navigationBar.tintColor = UIColor(named: "textColor")
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setUpTableView() {
        tableView.registerNib(class: NewsCell.self)
        tableView.registerNib(class: AwardsCell.self)
        tableView.registerNib(class: MoviesCell.self)
        tableView.registerNib(class: TvShowCell.self)
        tableView.registerNib(class: CelebrityCell.self)
       
       
    }

    
    //MARK: - Configure ViewModel
    private func configureViewModel() {
        newsManager = NewsManager()
        awardsManager = AwardsManager()
        viewModel = NewsViewModel(with: newsManager, awardsManager: awardsManager, controller: self)
        dataSource = NewsDataSource(with: tableView, viewModel: viewModel,vc: self)
        dataSource.refresh()
    }
}
