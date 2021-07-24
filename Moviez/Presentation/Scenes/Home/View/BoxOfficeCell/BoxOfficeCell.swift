//
//  BoxOfficeCell.swift
//  Moviez
//
//  Created by MacBook  on 09.07.21.
//

import UIKit

class BoxOfficeCell: UITableViewCell {

    
    @IBOutlet weak var boxOfficeCollectionView: UICollectionView!
    var boxOfficeList: [BoxOfficeViewModel]?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        boxOfficeCollectionView.registerNib(class: BoxOfficeItem.self)
        self.boxOfficeCollectionView.delegate = self
        self.boxOfficeCollectionView.dataSource = self
    }
    
    func configure(with items: [BoxOfficeViewModel]?) {

        self.boxOfficeList = items
        self.boxOfficeCollectionView.reloadData()
    }

}

extension BoxOfficeCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boxOfficeList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(BoxOfficeItem.self, for: indexPath)
        cell.configure(with: boxOfficeList?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 70)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
}
