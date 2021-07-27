//
//  ProfileViewController.swift
//  Moviez
//
//  Created by MacBook  on 05.06.21.
//

import UIKit
import FirebaseAuth
import SnapKit
import Firebase

class ProfileViewController: BaseViewController {
    
    
    // MARK: - Profile Outlets
    @IBOutlet weak var labelWelcomeUser: UILabel!
    @IBOutlet weak var buttonLogOut: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource: ProfileDataSource!
    private var viewModel: ProfileViewModelProtocol!
    private var firebaseManager: FirebaseManagerProtocol!
    let firebaseAuth = Auth.auth()
    let currentUserId =  Auth.auth().currentUser?.uid
    let currentUser =  Auth.auth().currentUser?.email
        
    //MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelWelcomeUser.text = "Welcome to Moviez \(currentUser?.dropLast(10).uppercased() ?? "")"
        setupLayout()
        configureDataSource()
        setupCollectioView()
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        navigationController?.isNavigationBarHidden = true
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.refreshFavorites()
        dataSource.refreshWatchlist()
        
        print(currentUserId)

    }
    
    func setupCollectioView() {
        collectionView.registerNib(class: ItemsCell.self)
        collectionView.registerNib(class: NothingAddedCell.self)
    }
    
    
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        dataSource.segmentedControlIndex = sender.selectedSegmentIndex
    }
    
    private func setupLayout() {
        buttonLogOut.layer.cornerRadius = 8
    }
    

    private func configureDataSource() {
        firebaseManager = FirebaseManager()
        viewModel = ProfileViewModel(with: firebaseManager)
        dataSource = ProfileDataSource(with: collectionView,
                                       viewModel: viewModel,
                                       controller: self)
        dataSource.segmentedControlIndex = segmentedControl.selectedSegmentIndex
        
    }
    @IBAction func onSignOut(_ sender: Any) {
        FirebaseHelper.signOut()
    }
}

