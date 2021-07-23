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
    
    //MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelWelcomeUser.text = ""
        setupLayout()
        configureDataSource()
        collectionView.registerNib(class: WaterfallLayoutCell.self)
        setupLongPressGesture()
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.refresh()
    }
    
    
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        dataSource.segmentedControlIndex = sender.selectedSegmentIndex
    }
    
    private func setupLayout() {
        buttonLogOut.layer.cornerRadius = 8
    }
    
    private func setupLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
    
    
    @objc func longTap(_ gesture: UIGestureRecognizer){
        switch gesture.state {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {return}
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collectionView.endInteractiveMovement()
            buttonDone.isHidden = false
            longPressedEnabled = true
            self.collectionView.reloadData()
        default:
            collectionView.cancelInteractiveMovement()
        }
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
        do {
            try firebaseAuth.signOut()
            NotificationCenter.default.post(name: .signedOut, object: nil)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

