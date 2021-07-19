//
//  ProfileDataSource.swift
//  Moviez
//
//  Created by MacBook  on 18.07.21.
//


import UIKit
import Firebase

class ProfileDataSource: NSObject {
    private var profilceCollectionView: UICollectionView!
    private var viewModel: ProfileViewModelProtocol!
    private var watchList: [[String: Any]]?
    let dataBase = Firestore.firestore()
    private var segmentedControl: UISegmentedControl!
    var usersWatchlisArray: [FirebaseModel]?
    var usersFavoritessArray: [FirebaseModel]?

    

    
    init(with profilceCollectionView: UICollectionView, viewModel: ProfileViewModelProtocol, segmentedControl: UISegmentedControl) {
        super.init()
        self.profilceCollectionView = profilceCollectionView
        self.viewModel = viewModel
        self.profilceCollectionView.delegate = self
        self.profilceCollectionView.dataSource = self
        self.profilceCollectionView.registerNib(class: SimilarItem.self)
        self.segmentedControl = segmentedControl
    }
    
    func refresh() {
        viewModel.fetchUsersWatchlist() { [weak self] watchlistArray in
            self?.usersWatchlisArray = watchlistArray
            self?.profilceCollectionView.reloadData()
        }
        
        viewModel.fetchUsersFavorites() { [weak self] favoritesArray in
            self?.usersFavoritessArray = favoritesArray
            self?.profilceCollectionView.reloadData()
        }
    }
    
}

extension ProfileDataSource: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return watchList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(SimilarItem.self, for: indexPath)
        cell.configure(with: usersWatchlisArray?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       return CGSize(width: UIScreen.main.bounds.width / 2 - 27.5 , height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}



