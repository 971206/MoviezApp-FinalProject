//
//  PersonDetailInfoViewController.swift
//  Moviez
//
//  Created by MacBook  on 26.06.21.
//

import UIKit

class PersonDetailInfoViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    private var dataSource: PersonDetailInfoDataSource!
    private var viewModel: PersonDetailInfoViewModelProtocol!
    private var personManager: PersonManagerProtocol!
    private var personCreditsManager: PersonCreditsManagerProtocol!
    var id: Int?
    var mediaType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()

        configureTableView()
    }
    
    
    
    private func configureDataSource() {
        personManager = PersonManager()
        personCreditsManager = PersonCreditsManager()
        viewModel = PersonDetailInfoViewModel(with: personManager,
                                              personCreditsManager: personCreditsManager)
        dataSource = PersonDetailInfoDataSource(with: tableView,
                                                viewModel: viewModel)
        dataSource.id = id
        dataSource.refresh()
        
    }
    
    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.registerNib(class: SimilarCell.self)
        tableView.registerNib(class: PersonDetailInfoCell.self)
    }

}

