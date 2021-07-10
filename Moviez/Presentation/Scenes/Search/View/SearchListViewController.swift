//
//  NewsViewController.swift
//  Moviez
//
//  Created by MacBook  on 05.06.21.
//

import UIKit

class SearchListViewController: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Private Properties
    private var searchManager : SearchManagerProtocol!
    private var dataSource: SearchDataSource!
    private var viewModel: SearchListViewModelProtocol!
    private var searchText = ""
    private var timer: Timer?
    
    //MARK: - VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureViewModel()
        setupSearchBar()
    }

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
          navigationController?.navigationBar.shadowImage = UIImage()
          navigationController?.navigationBar.isTranslucent = true
      
    }
    
    //MARK: - Setup TableView and Searchbar
    private func setupTableView() {
        tableView.registerNib(class: SearchResultCell.self)
        tableView.registerNib(class: EmptyCell.self)
        tableView.separatorStyle = .none
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.leftView?.tintColor = UIColor(named: "textColor")

    }
    
    //MARK: - Congifure ViewModel
    func configureViewModel() {
        searchManager = SearchManager()
        viewModel = SearchListViewModel(with: searchManager,
                                        navigationController: self.navigationController)
        dataSource = SearchDataSource(with: tableView,
                                      viewModel: viewModel,
                                      searchBar: searchBar,vc: self)
    }
    
    func startTimer() {
        self.view.startLoading()
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer(_:)), userInfo: nil, repeats: false)
    }
    
    @objc func fireTimer(_ sender: Any) {
        dataSource.search(with: searchText)
    }
}

    //MARK: - SearchBar Extension
extension SearchListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        startTimer()
        self.searchText = searchText
    }
}


