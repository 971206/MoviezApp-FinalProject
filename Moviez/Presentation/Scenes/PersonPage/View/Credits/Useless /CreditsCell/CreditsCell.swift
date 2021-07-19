////
////  CreditsCell.swift
////  Moviez
////
////  Created by MacBook  on 03.07.21.
////
//
//import UIKit
//
//class CreditsCell: UITableViewCell {
//    
//    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var labelHeader: UILabel!
//    
//    private var creditsManager: PersonCreditsManagerProtocol!
//    var creditsMovieList: [SearchModel]?
//    var creditsTvShowList: [SearchModel]?
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setUpCollectionView()
//        
//    }
//    
//    // MARK: - Setup CollectionView
//    func setUpCollectionView() {
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
//        collectionView.registerNib(class: CreditsItem.self)
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 130, height: 200)
//        layout.scrollDirection = .horizontal
//        collectionView.collectionViewLayout = layout
//    }
//    
////    func configureKnownFromTvShows(items: [SearchModel]?) {
////        creditsTvShowList = items
////        creditsMovieList = nil
////        collectionView.reloadData()
////        
////    }
////    func configureKnownFromMoviesitems(items: [SearchModel]?) {
////        creditsMovieList = items
////        creditsTvShowList = nil
////        collectionView.reloadData()
////        
////    }
//}
//
//extension CreditsCell: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let item = creditsMovieList {return item.count}
//        if let item = creditsTvShowList {return item.count}
//        return 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.deque(CreditsItem.self, for: indexPath)
//        if let creditMovie = creditsMovieList?[indexPath.row] {
//            cell.configureItem(with: creditMovie)
//            labelHeader.text = "Also known from Movies"
//        }
//        
//        if let creditTVShows = creditsTvShowList?[indexPath.row] {
//            cell.configureItem(with: creditTVShows)
//            labelHeader.text = "Also known from TV Shows"
//        }
//        return cell
//        
//    }
//}
//
//extension CreditsCell: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 16
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
//    }
//}
//
