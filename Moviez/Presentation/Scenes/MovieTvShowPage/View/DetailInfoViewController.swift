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
    private var profileViewModel: ProfileViewModelProtocol!
    private var firebaseManager: FirebaseManagerProtocol!
    var idOfItem: Int?
    var typeOfItem: MediaType.RawValue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.startLoading()
        configureDataSource()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
                                        with: self)
        dataSource = DetailInfoDataSource(with: tableView,
                                          viewModel: viewModel,
                                          vc: self)
        dataSource.id = idOfItem
        dataSource.mediaType = typeOfItem
        dataSource.refresh()
    }
    
    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.registerNib(class: BaseCell.self)
        tableView.registerNib(class: CastCell.self)
        tableView.registerNib(class: DescriptionCell.self)
    }
}

