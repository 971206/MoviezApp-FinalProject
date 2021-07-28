//
//  PersonDetailInfoViewController.swift
//  Moviez
//
//  Created by MacBook  on 26.06.21.
//

import UIKit

class PersonViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    private var dataSource: PersonDataSource!
    private var viewModel: PersonViewModelProtocol!
    private var personManager: PersonManagerProtocol!
    private var personCreditsManager: PersonCreditsManagerProtocol!
    var id: Int?
    var mediaType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationController()
    }
    
    
    private func setupNavigationController() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = UIColor(named: "lightBackground")
        navigationController?.navigationBar.tintColor = UIColor(named: "textColor")
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    
    private func configureDataSource() {
        personManager = PersonManager()
        personCreditsManager = PersonCreditsManager()
        viewModel = PersonViewModel(with: personManager,
                                              personCreditsManager: personCreditsManager, controller: self)
        dataSource = PersonDataSource(with: tableView,
                                                viewModel: viewModel)
        dataSource.id = id
        dataSource.refresh()
        
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.registerNib(class: BaseCell.self)
        tableView.registerNib(class: PersonInfoCell.self)
    }

}

