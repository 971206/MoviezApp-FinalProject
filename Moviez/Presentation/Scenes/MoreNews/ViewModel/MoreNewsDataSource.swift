//
//  MoreNewsDataSource.swift
//  Moviez
//
//  Created by MacBook  on 21.07.21.
//

import Foundation
import UIKit
//import  AVKit


class MoreNewsDataSource: NSObject {
    private var tableView: UITableView!
    
    private var controller: CoordinatorDelegate?
    
     var newsList: [Articles]?
    
    init(with tableView: UITableView, controller: CoordinatorDelegate) {
        super.init()
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.controller = controller
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let news = newsList?[indexPath.row] else {return}
        controller?.coordinator?.proceetToNewsDetail(with: news)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -15, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.7) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
