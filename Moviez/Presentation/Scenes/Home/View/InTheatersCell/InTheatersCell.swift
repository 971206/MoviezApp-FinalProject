//
//  InTheatersCell.swift
//  Moviez
//
//  Created by MacBook  on 18.07.21.
//

import UIKit

//MARK: - Delegate
protocol InTheatersCellDelegate: AnyObject {
    func onInTheatersClicked(movie: MoviesViewModel)
}

class InTheatersCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var inTheatersCollectionView: UICollectionView!
    
    private var inTheatersList: [MoviesViewModel]?
    weak var inTheatersCellDelegate: InTheatersCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        
    }
    
    //MARK: - Setup CollectioView
    func setupCollectionView(){
        inTheatersCollectionView.registerNib(class: InTheatersItem.self)
        inTheatersCollectionView.delegate = self
        inTheatersCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        inTheatersCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        inTheatersCollectionView.collectionViewLayout = layout
    }
    
    
    //MARK: - Configure
    func configureInTheatres(movies: [MoviesViewModel]) {
        inTheatersList = movies
        self.inTheatersCollectionView.reloadData()
    }
}

//MARK: - CollectionView DataSource
extension InTheatersCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inTheatersList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(InTheatersItem.self, for: indexPath)
        cell.configure(with: inTheatersList?[indexPath.row])
        return cell
    }
}
//MARK: - CollectionView Delegates
extension InTheatersCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = inTheatersList?[indexPath.row] {
            inTheatersCellDelegate?.onInTheatersClicked(movie: movie)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.6) {
            cell.alpha = 1
        }
    }
    
}
