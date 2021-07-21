//
//  MoreNewsDataSource.swift
//  Moviez
//
//  Created by MacBook  on 21.07.21.
//

import Foundation

class MoreNewsDataSource: NSObject {
    private var tableView: UITableView!
    
     var newsList: [Articles]?
    
    init(with tableView: UITableView) {
        super.init()
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    
}

extension MoreNewsDataSource: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(NewsCell.self, for: indexPath)
        cell.configure(with: newsList?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
