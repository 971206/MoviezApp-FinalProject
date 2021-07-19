//
//  InTheatersCell.swift
//  Moviez
//
//  Created by MacBook  on 18.07.21.
//

import UIKit

protocol InTheatersCellDelegate: AnyObject {
    func onInTheatersClicked(movie: Movies)
}

class InTheatersCell: UITableViewCell {

    @IBOutlet weak var inTheatersCollectionView: UICollectionView!
    
    private var inTheatersList: [Movies]?
    weak var inTheatersCellDelegate: InTheatersCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        
    }

    func setupCollectionView(){
        inTheatersCollectionView.registerNib(class: InTheatersItem.self)
        inTheatersCollectionView.delegate = self
        inTheatersCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        inTheatersCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: 320, height: 160)
        inTheatersCollectionView.collectionViewLayout = layout
    }


    
    func configureInTheares(movies: [Movies]) {
        inTheatersList = movies
       self.inTheatersCollectionView.reloadData()
       
   }
    
}


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

extension InTheatersCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 190)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 16
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = inTheatersList?[indexPath.row] {
            inTheatersCellDelegate?.onInTheatersClicked(movie: movie)
        }

    }
  
}
