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
    @IBOutlet weak var buttonDone: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource: ProfileDataSource!
    private var viewModel: ProfileViewModelProtocol!
    private var firebaseManager: FirebaseManagerProtocol!
    let firebaseAuth = Auth.auth()
    var longPressedEnabled = false
    let currentUser =  Auth.auth().currentUser?.uid
    let firebaseHelper = FirebaseHelper()
    
    //MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelWelcomeUser.text = ""
        setupLayout()
        configureDataSource()
        collectionView.registerNib(class: ProfileCell.self)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.refreshFavorites()
        dataSource.refreshWatchlist()
      
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

