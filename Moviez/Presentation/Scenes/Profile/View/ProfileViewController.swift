//
//  ProfileViewController.swift
//  Moviez
//
//  Created by MacBook  on 05.06.21.
//

import UIKit
import FirebaseAuth
import SnapKit

class ProfileViewController: BaseViewController {
    
    lazy var box = UIView()
    
    // MARK: - Profile Outlets
    @IBOutlet weak var labelWelcomeUser: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let segmentindicator: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.systemPink
        return v
    }()
    
    //MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-Medium", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor(named: "lightBackground")], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-Medium", size: 24)!, NSAttributedString.Key.foregroundColor: UIColor.systemPink], for: .selected)
        self.view.addSubview(segmentindicator)
        segmentindicator.snp.makeConstraints { (make) in
            make.top.equalTo(segmentedControl.snp.bottom).offset(3)
            make.height.equalTo(2)
            make.width.equalTo(15 + segmentedControl.titleForSegment(at: 0)!.count * 8)
            make.centerX.equalTo(segmentedControl.snp.centerX).dividedBy(segmentedControl.numberOfSegments)
            make.width.equalTo(segmentedControl.snp.width).multipliedBy(1 / CGFloat(segmentedControl.numberOfSegments) / 1.5)
            
            
            
        }
        
        //    override func viewWillAppear(_ animated: Bool) {
        //        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "darkBackground") ?? .black], for: .selected)
        //        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        //    }
    }
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        let numberOfSegments = CGFloat(segmentedControl.numberOfSegments)
        let selectedIndex = CGFloat(sender.selectedSegmentIndex)
        let titlecount = CGFloat((segmentedControl.titleForSegment(at: sender.selectedSegmentIndex)!.count))
        segmentindicator.snp.remakeConstraints { (make) in
            make.top.equalTo(segmentedControl.snp.bottom).offset(3)
            make.height.equalTo(2)
            make.width.equalTo(15 + titlecount * 8)
            make.centerX.equalTo(segmentedControl.snp.centerX).dividedBy(numberOfSegments / CGFloat(3.0 + CGFloat(selectedIndex-1.0)*2.0))
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.7, animations: {
                self.view.layoutIfNeeded()
                self.segmentindicator.transform = CGAffineTransform(scaleX: 1.4, y: 1)
            }) { (finish) in
                UIView.animate(withDuration: 0.4, animations: {
                    self.segmentindicator.transform = CGAffineTransform.identity
                })
            }
            
        }
    }
}
