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
     var newsList: [ArticleViewModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(class: NewsCell.self)
       configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = UIColor(named: "lightBackground")
        navigationController?.navigationBar.tintColor = UIColor(named: "textColor")
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func configureDataSource() {
        dataSource = MoreNewsDataSource(with: tableView, controller: self)
        dataSource.newsList = newsList
    }
}
