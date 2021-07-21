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
    let firebaseAuth = Auth.auth()
    var longPressedEnabled = false
    
    //MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonLogOut.layer.cornerRadius = 8
        self.navigationController?.isNavigationBarHidden = true
        collectionView.registerNib(class: WaterfallLayoutCell.self)
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
        collectionView.addGestureRecognizer(longPressGesture)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureDataSource()
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
    
    
    
    
    
    func configureDataSource() {
        viewModel = ProfileViewModel()
        dataSource = ProfileDataSource(with: collectionView,
                                       viewModel: viewModel,
                                       segmentedControl: segmentedControl,
                                       controller: self)
        dataSource.refresh()
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

