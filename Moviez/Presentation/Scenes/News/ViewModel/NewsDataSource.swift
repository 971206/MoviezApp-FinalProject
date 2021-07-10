//
//  NewsDataSource.swift
//  Moviez
//
//  Created by MacBook  on 13.06.21.
//

import UIKit

class NewsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    //MARK: - Private Properties
    private var tableView: UITableView!
    private var newsList: [News]?
    private var viewModel: NewsViewModelProtocol!
    private var vc: NewsViewController?
    
    init(with tableView: UITableView, viewModel: NewsViewModelProtocol,vc: NewsViewController?) {
        super.init()
        self.tableView = tableView
        self.tableView.dataSource = self
        self.viewModel = viewModel
        self.tableView.delegate = self
        self.vc = vc
    }
    
    func fetchNews() {
        viewModel.fetchNews { news in
            self.newsList = news
            self.vc?.view.stopLoading()
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(NewsCell.self, for: indexPath)
        cell.configure(with: newsList?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsItem = newsList?[indexPath.row].url ?? ""
        UIApplication.shared.openURL(NSURL(string: newsItem)! as URL)
    }
}

