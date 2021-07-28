//
//  ReviewsDataSource.swift
//  Moviez
//
//  Created by MacBook  on 11.06.21.
//

import UIKit

class ReviewsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Private Properties
    private var tableView: UITableView!
    private var viewModel: ReviewsListViewModelProtocol!
    private var reviewsList: [Review]?
    
    init(with tableView: UITableView, viewModel: ReviewsListViewModelProtocol) {
        super.init()
        self.tableView = tableView
        self.viewModel = viewModel
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    
    //MARK: - Refresh
    func refresh(with id: Int, type: String) {
        viewModel.fetchReviewsList(id: id, type: type) { [weak self] reviewsList in
            guard let self = self else {return}
            self.reviewsList = reviewsList
            self.tableView.reloadData()
        }
    }
    
    //MARK: - TableView DataSource And Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if reviewsList?.count == 0 || reviewsList == nil { return 1 }
        return reviewsList?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if reviewsList?.count == 0 || reviewsList == nil {
            let cell = tableView.deque(NoReviewsCell.self, for: indexPath)
            return cell
        }
        let cell = tableView.deque(ReviewsCell.self, for: indexPath)
        cell.configure(with: reviewsList?[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if reviewsList?.count == 0 || reviewsList == nil {
            return 440
        } else {
            return UITableView.automaticDimension
        }
    }
}
