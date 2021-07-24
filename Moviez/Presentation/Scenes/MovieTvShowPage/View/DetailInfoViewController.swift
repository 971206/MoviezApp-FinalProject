//
//  DetailViewController.swift
//  Moviez
//
//  Created by MacBook  on 27.06.21.
//

import UIKit

class DetailInfoViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var detailsManager: DetailsManagerProtocol!
    private var similarItemManager: SimilarItemsManagerProtocol!
    private var recommendedItemManager: RecommendedManagerProtocol!
    private var castManager: CastManagerProtocol!
    private var dataSource: DetailInfoDataSource!
    private var viewModel: DetailInfoViewModel!
    var navCont: UINavigationController!
    private var profileViewModel: ProfileViewModelProtocol!
    private var firebaseManager: FirebaseManagerProtocol!
    
    var similarItemsList: [SearchModel]?
    var recommendedItemsList: [SearchModel]?
    
    
    var idOfItem: Int?
    var typeOfItem: MediaType.RawValue?
    var detailInfo: MovieTvShowDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(named: "lightBackground")
        navigationController?.navigationBar.tintColor = UIColor(named: "textColor")
//        navigationController?.isNavigationBarHidden = true
//        tableView.contentInsetAdjustmentBehavior = .never

    }
    
    private func configureDataSource() {
        detailsManager = DetailsManager()
        similarItemManager = SimilarItemsManager()
        recommendedItemManager = RecommendedManager()
        castManager = CastManager()
        firebaseManager = FirebaseManager()
        profileViewModel = ProfileViewModel(with: firebaseManager)
        viewModel = DetailInfoViewModel(with: similarItemManager,
                                        with: recommendedItemManager,
                                        with: detailsManager,
                                        with: castManager,
                                        with: navigationController!, with: self)
        dataSource = DetailInfoDataSource(with: tableView,
                                          viewModel: viewModel,
                                          navigationController: navigationController!)
        dataSource.id = idOfItem
        dataSource.mediaType = typeOfItem
        dataSource.refresh()
    }
    
    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.registerNib(class: SimilarCell.self)
        tableView.registerNib(class: CastCell.self)
        tableView.registerNib(class: DescriptionCell.self)
        tableView.registerNib(class: SeasonCell.self)
    }
}


