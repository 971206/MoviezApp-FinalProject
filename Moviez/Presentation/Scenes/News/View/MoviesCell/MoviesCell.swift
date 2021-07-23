//
//  MoviesCell.swift
//  Moviez
//
//  Created by MacBook  on 20.07.21.
//

import UIKit

protocol MovieNewsCellDelegate: AnyObject {
    func onNewsCellClicked(news: ArticleViewModel?)
}

class MoviesCell: UITableViewCell {

    @IBOutlet weak var onReadMore: UIButton!
    @IBOutlet weak var movieNewsCollectionView: UICollectionView!
    
    private var movieNewsList: [ArticleViewModel]?
    weak var movieNewsCellDelegate: MovieNewsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCollectionView()
    }
    
    func configureCollectionView() {
        self.movieNewsCollectionView.dataSource = self
        self.movieNewsCollectionView.delegate = self
        movieNewsCollectionView.registerNib(class: MoviesItem.self)
    }
    
    func configure(with items: [ArticleViewModel]?) {
        self.movieNewsList = items
        self.movieNewsCollectionView.reloadData()
    }


}

extension MoviesCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieNewsList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(MoviesItem.self, for: indexPath)
        cell.configure(with: movieNewsList?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieNewsCellDelegate?.onNewsCellClicked(news: movieNewsList?[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 230, height: 270)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    
}
