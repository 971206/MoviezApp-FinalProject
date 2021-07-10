//
//  ReviesViewController.swift
//  Moviez
//
//  Created by MacBook  on 11.06.21.
//

import UIKit

class ReviewsListViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Private Properties
    private var viewModel: ReviewsListViewModelProtocol!
    private var dataSource: ReviewsDataSource!
    private var reviewsManager: ReviewsManagerProtocol!
    
    //MARK: -Internal Properties
    var type: String?
    var id: Int?
    
    //MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        fetchReviews()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.registerNib(class: ReviewsCell.self)
        tableView.registerNib(class: NoReviewsCell.self)
        tableView.separatorStyle = .none
    }

    private func configureViewModel() {
        reviewsManager = ReviewsManager()
        viewModel = ReviewsListViewModel(with: reviewsManager)
        dataSource = ReviewsDataSource(with: tableView, viewModel: viewModel)
    }
    
    private func fetchReviews() {
        dataSource.refresh(with: id ?? 0, type: type ?? "")
        tableView.reloadData()
    }
    
}

