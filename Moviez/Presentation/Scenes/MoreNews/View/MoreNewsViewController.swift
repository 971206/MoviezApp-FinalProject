//
//  MoreNewsViewController.swift
//  Moviez
//
//  Created by MacBook  on 21.07.21.
//

import UIKit

class MoreNewsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    private var dataSource: MoreNewsDataSource!
     var newsList: [Articles]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(class: NewsCell.self)
       configureDataSource()
    }
    
    func configureDataSource() {
        dataSource = MoreNewsDataSource(with: tableView, controller: self)
        dataSource.newsList = newsList
    }
}
