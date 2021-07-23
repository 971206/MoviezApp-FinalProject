//
//  TvShowCell.swift
//  Moviez
//
//  Created by MacBook  on 21.07.21.
//

import UIKit

protocol TvShowCellDelegate: AnyObject {
    func onTvShowCellClicked(news: ArticleViewModel?)
}


class TvShowCell: UITableViewCell {

    @IBOutlet weak var onReadMore: UIButton!
    @IBOutlet weak var tvShowCollectionView: UICollectionView!
    private var tvShowNewsList: [ArticleViewModel]?
    weak var tvShowCellDelegate: TvShowCellDelegate?

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
    }

    private func configureCollectionView() {
        tvShowCollectionView.registerNib(class: TvShowItem.self)
        tvShowCollectionView.delegate = self
        tvShowCollectionView.dataSource = self
    }
    
    func configure(with items: [ArticleViewModel]?) {
        self.tvShowNewsList = items
        self.tvShowCollectionView.reloadData()
    }

}

extension TvShowCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvShowNewsList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(TvShowItem.self, for: indexPath)
        cell.configure(with: tvShowNewsList?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tvShowCellDelegate?.onTvShowCellClicked(news: tvShowNewsList?[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 32, height: 130)
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
