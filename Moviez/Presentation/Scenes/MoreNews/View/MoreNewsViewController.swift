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
    private var viewModel: MoreNewsViewModelProtcol!
    private var newsManager: NewsManagerProtocol!
    
    var category: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(class: NewsCell.self)
        configureDataSource()
        showMoreNews()
    }
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        showMoreNews()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = UIColor(named: "lightBackground")
        navigationController?.navigationBar.tintColor = UIColor(named: "textColor")
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    
    
    func showMoreNews() {
        switch category {
        case Categories.celebrity.rawValue:
            dataSource.fetchCelebrityNews()
        case Categories.movie.rawValue:
            dataSource.fetchMovieNews()
        case Categories.show.rawValue:
            dataSource.fetchTvShowNews()
        default:
            break
        }
    }
    
    
    func configureDataSource() {
        newsManager = NewsManager()
        viewModel = MoreNewsViewModel(with: newsManager, controller: self)
        dataSource = MoreNewsDataSource(with: tableView, viewModel: viewModel, controller: self, vc: self)
     
    }
}
