//
//  RecommendationCell.swift
//  Moviez
//
//  Created by MacBook  on 26.07.21.
//

import UIKit

protocol RecommendationCellDelegate: AnyObject {
    func onRecommendationClicked(id: Int, mediaType: String)
}



class RecommendationCell: UITableViewCell {

    @IBOutlet weak var recommendedCollectionView: UICollectionView!
    
    private var recommendationsForCurrentUser: [SearchModel]?
    weak var recommendationDelegate: RecommendationCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recommendedCollectionView.delegate = self
        recommendedCollectionView.dataSource = self
        recommendedCollectionView.registerNib(class: WatchlistItem.self)
    }
    
    func configure(with item: [SearchModel]?) {
        self.recommendationsForCurrentUser = item
        self.recommendedCollectionView.reloadData()
    }
}

extension RecommendationCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendationsForCurrentUser?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(WatchlistItem.self, for: indexPath)
        cell.configure(with: recommendationsForCurrentUser?[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = recommendationsForCurrentUser?[indexPath.row].id,
           let mediaType = recommendationsForCurrentUser?[indexPath.row].mediaType {
            recommendationDelegate?.onRecommendationClicked(id: id, mediaType: mediaType)
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
