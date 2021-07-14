//
//  CastCell.swift
//  Moviez
//
//  Created by MacBook  on 27.06.21.
//

import UIKit

protocol CastCellDelegate: AnyObject {
    func onCastClicked(personId: Int)
}



class CastCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    private var castManager: CastManagerProtocol!
    private var castList: [Person]?
    weak var delegate: CastCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }
    
    
    // MARK: - Setup CollectionView
    func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.registerNib(class: CastItem.self)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 130, height: 230)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
    }
    
    func configureCastList(items: [Person]) {
        castList = items
        collectionView.reloadData()
    }}

extension CastCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(CastItem.self, for: indexPath)
        cell.configure(with: castList?[indexPath.row])
        return cell
    }
}

extension CastCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let personId = castList?[indexPath.row].id else {return}
        delegate?.onCastClicked(personId: personId)
        
    }
}
