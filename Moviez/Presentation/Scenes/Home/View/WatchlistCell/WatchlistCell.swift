//
//  WatchlistCell.swift
//  Moviez
//
//  Created by MacBook  on 20.07.21.
//

import UIKit

protocol WatchlistCellDelegate: AnyObject {
    func onWatchlisClicked(id: Int, mediaType: String)
}


class WatchlistCell: UITableViewCell {

    @IBOutlet weak var onSeeAll: UIButton!
    @IBOutlet weak var watchlistCollectionView: UICollectionView!
    
    private var profileViewModel: ProfileViewModelProtocol!
    private var usersWatchlist: [FirebaseModelViewModel]?
    weak var watchlistDelegate: WatchlistCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        watchlistCollectionView.delegate = self
        watchlistCollectionView.dataSource = self
        watchlistCollectionView.registerNib(class: WatchlistItem.self)
    }
    
    func configure(with item: [FirebaseModelViewModel]?) {
        self.usersWatchlist = item
        self.watchlistCollectionView.reloadData()
    }
}

extension WatchlistCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersWatchlist?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(WatchlistItem.self, for: indexPath)
        cell.configure(with: usersWatchlist?[indexPath.row])
        return cell
    }
    
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
}
