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
    
    //MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.startLoading()
        tableView.registerNib(class: NewsCell.self)
        configureViewModel()
        fetchNews()
    }

    
    //MARK: - Configure ViewModel
    private func configureViewModel() {
        newsManager = NewsManager()
        viewModel = NewsViewModel(with: newsManager)
        dataSource = NewsDataSource(with: tableView, viewModel: viewModel,vc: self)
    }
    
    //MARK: - Fetch News
    private func fetchNews() {
        dataSource.fetchNews()
        tableView.reloadData()
    }
}
