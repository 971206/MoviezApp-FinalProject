//
//  WatchlistCell.swift
//  Moviez
//
//  Created by MacBook  on 20.07.21.
//

import UIKit

//MARK: - Delegate
protocol WatchlistCellDelegate: AnyObject {
    func onWatchlisClicked(id: Int, mediaType: String)
}

class WatchlistCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var watchlistCollectionView: UICollectionView!
    
    //MARK: - Private Properties
    private var usersWatchlist: [FirebaseModel]?
    
    weak var watchlistDelegate: WatchlistCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        watchlistCollectionView.delegate = self
        watchlistCollectionView.dataSource = self
        watchlistCollectionView.registerNib(class: WatchlistItem.self)
    }
    
    //MARK: - Configure
    func configure(with item: [FirebaseModel]?) {
        self.usersWatchlist = item
        self.watchlistCollectionView.reloadData()
    }
}

//MARK: - CollectioView DataSource
extension WatchlistCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersWatchlist?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(WatchlistItem.self, for: indexPath)
        cell.configure(with: usersWatchlist?[indexPath.row])
        return cell
    }
}

//MARK: - CollectionView Delegates
extension WatchlistCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = usersWatchlist?[indexPath.row].id,
           let mediaType = usersWatchlist?[indexPath.row].mediaType {
            watchlistDelegate?.onWatchlisClicked(id: id, mediaType: mediaType)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
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
