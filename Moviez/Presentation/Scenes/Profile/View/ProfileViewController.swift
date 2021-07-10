//
//  ProfileViewController.swift
//  Moviez
//
//  Created by MacBook  on 05.06.21.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    
    // MARK: - Profile Outlets
    @IBOutlet weak var labelWelcomeUser: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
   
    
    //MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "darkBackground") ?? .black], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
}
