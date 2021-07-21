//
//  ProfileDataSource.swift
//  Moviez
//
//  Created by MacBook  on 18.07.21.
//


import UIKit
import Firebase


class ProfileDataSource: NSObject {
    private var profileCollectionView: UICollectionView!
    private var viewModel: ProfileViewModelProtocol!
    let dataBase = Firestore.firestore()
    private var segmentedControl: UISegmentedControl!
    var usersWatchlisArray: [FirebaseModel]?
    var usersFavoritessArray: [FirebaseModel]?
    var controller: CoordinatorDelegate?



    
    init(with profilceCollectionView: UICollectionView, viewModel: ProfileViewModelProtocol, segmentedControl: UISegmentedControl, controller: CoordinatorDelegate) {
        super.init()
        self.controller = controller
        self.profileCollectionView = profilceCollectionView
        self.viewModel = viewModel
        self.profileCollectionView.delegate = self
        self.profileCollectionView.dataSource = self
        self.segmentedControl = segmentedControl
        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 2
        profileCollectionView.collectionViewLayout = layout
    }
    

    
    
    func refresh() {
        viewModel.fetchUsersWatchlist() { [weak self] watchlistArray in
            self?.usersWatchlisArray = watchlistArray
            self?.profileCollectionView.reloadData()
        }
        
        viewModel.fetchUsersFavorites() { [weak self] favoritesArray in
            self?.usersFavoritessArray = favoritesArray
            self?.profileCollectionView.reloadData()
            
        }
    }
    
}

extension ProfileDataSource: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersWatchlisArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.deque(WaterfallLayoutCell.self, for: indexPath)
        cell.configure(with: usersWatchlisArray?[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = usersWatchlisArray?[indexPath.row].id else {return}
        guard let mediaType = usersWatchlisArray?[indexPath.row].mediaType else {return}
        controller?.coordinator?.proceedToMovieAndTvShowDetailInfo(id: id, mediaType: mediaType)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: profileCollectionView.bounds.height / 2 , height:CGFloat.random(in: 260...360))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingFor section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
        
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    
}



