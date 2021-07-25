//
//  AwardsCell.swift
//  Moviez
//
//  Created by MacBook  on 19.07.21.
//

import UIKit

class AwardsCell: UITableViewCell {

    
    private var awardsList: [Awards]?
    
    @IBOutlet weak var awardsCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }

    private func setupCollectionView() {
        awardsCollectionView.isScrollEnabled = false
        awardsCollectionView.dataSource = self
        awardsCollectionView.delegate = self
        awardsCollectionView.registerNib(class: AwardsItem.self)
    }
    func configure(with items: [Awards]?) {
        self.awardsList = items
        self.awardsCollectionView.reloadData()
    }
}

extension AwardsCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return awardsList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(AwardsItem.self, for: indexPath)
        cell.configure(with: awardsList?[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: UIScreen.main.bounds.width / 2 - 27.5 , height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return  UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newsURL = URL(string: awardsList?[indexPath.row].endpoint ?? "")
        if let newsURL = newsURL {
            UIApplication.shared.open(newsURL)
        }
    }
    
}
