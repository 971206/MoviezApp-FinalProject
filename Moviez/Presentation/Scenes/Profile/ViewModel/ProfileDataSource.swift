//
//  ProfileDataSource.swift
//  Moviez
//
//  Created by MacBook  on 18.07.21.
//


import UIKit
import Firebase
import FirebaseAuth


class ProfileDataSource: NSObject {
    private var profileCollectionView: UICollectionView!
    private var viewModel: ProfileViewModelProtocol!
    private var segmentedControl: UISegmentedControl!
    var usersWatchlistArray: [FirebaseModel]?
    var usersFavoritesArray: [FirebaseModel]?
    var controller: CoordinatorDelegate?
    var segmentedControlIndex = 0 {
        didSet{
            self.profileCollectionView.reloadData()
        }
    }

    
    init(with profilceCollectionView: UICollectionView, viewModel: ProfileViewModelProtocol, controller: CoordinatorDelegate) {
        super.init()
        self.controller = controller
        self.profileCollectionView = profilceCollectionView
        self.viewModel = viewModel
        self.profileCollectionView.delegate = self
        self.profileCollectionView.dataSource = self
        
        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 2
        profileCollectionView.collectionViewLayout = layout
    }
    
    
    func refresh() {
        viewModel.fetchUsersWatchlist() { [weak self] watchlistArray in
            self?.usersWatchlistArray = watchlistArray
            self?.profileCollectionView.reloadData()
        }
        
        viewModel.fetchUsersFavorites() { [weak self] favoritesArray in
            self?.usersFavoritesArray = favoritesArray
            self?.profileCollectionView.reloadData()
            
        }
        
    }
    
}

extension ProfileDataSource: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch segmentedControlIndex {
        case 0:
            return usersWatchlistArray?.count ?? 0
        case 1:
            return usersFavoritesArray?.count ?? 0
        default:
            return 0
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.deque(WaterfallLayoutCell.self, for: indexPath)
        switch segmentedControlIndex {
        case 0:
            cell.configure(with: usersWatchlistArray?[indexPath.row])
            return cell
        case 1:
            cell.configure(with: usersFavoritesArray?[indexPath.row])
            return cell
        default:
            return cell
        }
     
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = usersWatchlistArray?[indexPath.row].id else {return}
        guard let mediaType = usersWatchlistArray?[indexPath.row].mediaType else {return}
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



