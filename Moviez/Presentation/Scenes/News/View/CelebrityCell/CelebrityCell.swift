//
//  CelebrityCell.swift
//  Moviez
//
//  Created by MacBook  on 21.07.21.
//

import UIKit

//MARK: - Delegate
protocol CelebrityCellDelegate: AnyObject {
    func onCelebrityCellClicked(news: ArticleViewModel?)
}

class CelebrityCell: UITableViewCell {
//MARK: - IBOutlets
    @IBOutlet weak var celebrityCollectionView: UICollectionView!
    @IBOutlet weak var onReadMore: UIButton!
    
    private var celebrityNewsList: [ArticleViewModel]?
    weak var celebrityCellDelegate: CelebrityCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       setupCollectionView()
    }

    func setupCollectionView() {
        celebrityCollectionView.registerNib(class: CelebrityItem.self)
        celebrityCollectionView.delegate = self
        celebrityCollectionView.dataSource = self
    }
    
    func configure(with items: [ArticleViewModel]?) {
        self.celebrityNewsList = items
        self.celebrityCollectionView.reloadData()
    }
}

//MARK: - CollectionView DataSource
extension CelebrityCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return celebrityNewsList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(CelebrityItem.self, for: indexPath)
        cell.configure(with: celebrityNewsList?[indexPath.row])
        return cell
    }
    
}

//MARK: - CollectionView Delegate
extension CelebrityCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        celebrityCellDelegate?.onCelebrityCellClicked(news: celebrityNewsList?[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width * 2/3 , height: 120)
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
      cell.alpha = 0
      UIView.animate(withDuration: 0.6) {
          cell.alpha = 1
      }
  }
}
