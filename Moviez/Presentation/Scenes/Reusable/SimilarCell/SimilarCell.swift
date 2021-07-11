//
//  SimilarCell.swift
//  Moviez
//
//  Created by MacBook  on 27.06.21.
//

import UIKit

protocol SimilarCellDelegate: AnyObject {
    func onSimilarClicked(id: Int)
    func onRecommendedClicked(id: Int)
}


class SimilarCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelHeader: UILabel!
    private var apiManagerOfSimilarItems: SimilarItemsManagerProtocol!
    private var apiManagerOfRecommendedItems: RecommendedApiManagerProtocol!
    private var similarItemsList: [SearchModel]?
    private var recommendedItemsList: [SearchModel]?
    weak var delegate: SimilarCellDelegate!
    private var creditsManager: PersonCreditsManagerProtocol!
    var creditsMovieList: [SearchModel]?
    var creditsTvShowList: [SearchModel]?

    
    
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
            collectionView.registerNib(class: SimilarItem.self)
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 130, height: 240)
            layout.scrollDirection = .horizontal
            collectionView.collectionViewLayout = layout
            
        }

    func configureSimilarItems(items:[SearchModel]) {
        similarItemsList = items
        recommendedItemsList = nil
        collectionView.reloadData()
    }
    
    func configureRecommenderItems(items: [SearchModel]) {
        recommendedItemsList = items
        similarItemsList = nil
        collectionView.reloadData()
    }
    
    func configureKnownFromTvShows(items: [SearchModel]?) {
        creditsTvShowList = items
        creditsMovieList = nil
        collectionView.reloadData()
        
    }
    func configureKnownFromMoviesitems(items: [SearchModel]?) {
        creditsMovieList = items
        creditsTvShowList = nil
        collectionView.reloadData()
        
    }
    

    
}

extension SimilarCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let item = similarItemsList { return item.count }
        if let item = recommendedItemsList { return item.count }
        if let item = creditsTvShowList { return item.count }
        if let item = creditsMovieList { return item.count }

        
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(SimilarItem.self, for: indexPath)
        if let similarItem = similarItemsList?[indexPath.row] {
            cell.configureItem(with: similarItem)
            labelHeader.text = "Similar"
        }
        if let recommendedItem = recommendedItemsList?[indexPath.row] {
            cell.configureItem(with: recommendedItem)
            labelHeader.text = "People watching this also like"
        }
        if let creditsTvShows = creditsTvShowList?[indexPath.row] {
            cell.configureItem(with: creditsTvShows)
            labelHeader.text = "Known From TV Shows"
        }
        if let creditsMovie = creditsMovieList?[indexPath.row] {
            cell.configureItem(with: creditsMovie)
            labelHeader.text = "Known From Movies"
        }
        
        
        
  
        return cell
    }
}

extension SimilarCell: UICollectionViewDelegate {
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
        if let similarItemId = similarItemsList?[indexPath.row].id{
            delegate.onSimilarClicked(id: similarItemId)
        }
        if let recommendedItemId = recommendedItemsList?[indexPath.row].id {
            delegate.onRecommendedClicked(id:recommendedItemId)
        }
    }
}