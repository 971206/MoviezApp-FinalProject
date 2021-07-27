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
    let firebaseHelper = FirebaseHelper()
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
        let layout = UICollectionViewFlowLayout()
        profileCollectionView.collectionViewLayout = layout

    }
    
    func refreshWatchlist() {
        viewModel.fetchUsersWatchlist() { [weak self] watchlistArray in
            self?.usersWatchlistArray = watchlistArray
            self?.profileCollectionView.reloadData()
        }
    }
    
    func refreshFavorites() {
        viewModel.fetchUsersFavorites() { [weak self] favoritesArray in
            self?.usersFavoritesArray = favoritesArray
            self?.profileCollectionView.reloadData()
            
        }

    }
    
}

extension ProfileDataSource: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch segmentedControlIndex {
        case 0:
            if usersWatchlistArray?.count == 0 || usersWatchlistArray == nil { return 1 }
            return usersWatchlistArray?.count ?? 0
        case 1:
            if usersFavoritesArray?.count == 0 || usersFavoritesArray == nil { return 1 }
            return usersFavoritesArray?.count ?? 0
        default:
            return 0
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.deque(ItemsCell.self, for: indexPath)
        switch segmentedControlIndex {
        case 0:
            if usersWatchlistArray?.count == 0 || usersWatchlistArray == nil {
                let cell = collectionView.deque(NothingAddedCell.self, for: indexPath)
                cell.configureEmptyWatchlist()
                return cell
            }
            cell.configure(with: usersWatchlistArray?[indexPath.row])
            cell.delegate = self
            return cell
        case 1:
            if usersFavoritesArray?.count == 0 || usersFavoritesArray == nil {
                let cell = collectionView.deque(NothingAddedCell.self, for: indexPath)
                cell.configureEmptyFavorites()
                return cell
            }
            cell.configure(with: usersFavoritesArray?[indexPath.row])
            cell.delegate = self
            return cell
        default:
            return cell
        }
    }
    
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch segmentedControlIndex {
        case 0:
            guard usersWatchlistArray?.count != 0 else { return }
            guard let id = usersWatchlistArray?[indexPath.row].id else {return}
            guard let mediaType = usersWatchlistArray?[indexPath.row].mediaType else {return}
            controller?.coordinator?.proceedToMovieAndTvShowDetailInfo(id: id, mediaType: mediaType)
        case 1:
            guard usersFavoritesArray?.count != 0 else { return }
            guard let id = usersFavoritesArray?[indexPath.row].id else {return}
            guard let mediaType = usersFavoritesArray?[indexPath.row].mediaType else {return}
            controller?.coordinator?.proceedToMovieAndTvShowDetailInfo(id: id, mediaType: mediaType)
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch  segmentedControlIndex {
        case 0:
            if usersWatchlistArray?.count == 0 || usersWatchlistArray == nil {
                return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
            } else {
                return CGSize(width: UIScreen.main.bounds.width / 2 - 24 , height: 280)
            }
        case 1:
            if usersFavoritesArray?.count == 0 || usersFavoritesArray == nil {
                return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
            } else {
                return CGSize(width: UIScreen.main.bounds.width / 2 - 24 , height: 280)
            }
        default:
            return .init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
      cell.alpha = 0
      UIView.animate(withDuration: 0.6) {
          cell.alpha = 1
      }
  }
    
}


extension ProfileDataSource: ItemsCellDelegate {
    func delete(cell: ItemsCell) {
        if let indexPath = profileCollectionView?.indexPath(for: cell) {
            var favoritesID = String()
            var watchlistID = String()
            switch segmentedControlIndex {
            case 0:
                if !(usersWatchlistArray?.isEmpty ?? true) {
                    watchlistID = String("\(usersWatchlistArray?[indexPath.row].id ?? 0)")
                    FirebaseHelper.deleteSavedItems(id: watchlistID, collection: "watchlists")
                    refreshWatchlist()
                }
            case 1:
                if !(usersFavoritesArray?.isEmpty ?? true) {
                    favoritesID = String("\(usersFavoritesArray?[indexPath.row].id ?? 0)")
                    FirebaseHelper.deleteSavedItems(id: favoritesID, collection: "favorites")
                    refreshFavorites()
                }
            default:
                break
            }
        }
    }
}
