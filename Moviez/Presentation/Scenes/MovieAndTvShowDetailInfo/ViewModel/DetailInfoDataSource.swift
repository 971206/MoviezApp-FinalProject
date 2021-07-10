//
//  DetailInfoDataSource.swift
//  Moviez
//
//  Created by MacBook  on 11.06.21.
//

import UIKit

//class DetailInfoDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
//    private var collectionView: UICollectionView!
//    private var viewModel: DetailInfoViewModelProtocol!
//    private var similarItems: [SearchModel]?
//    var type: String?
//
//
//
//    init(with collectionView: UICollectionView, viewModel: DetailInfoViewModelProtocol) {
//        super.init()
//        self.collectionView = collectionView
//        self.viewModel = viewModel
//        self.collectionView.dataSource = self
//        self.collectionView.delegate = self
//
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return similarItems?.count ?? 0
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.deque(SimilarItem.self, for: indexPath)
//        cell.configureItem(with: similarItems?[indexPath.row])
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if type == "tv" {
//            viewModel.proceedToDetailsWhenTvShowSelected(with: (similarItems?[indexPath.row])!)
//        } else {
//            viewModel.proceedToDetailsWhenMovieSelected(with: (similarItems?[indexPath.row])!)
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//      cell.alpha = 0
//      UIView.animate(withDuration: 0.6) {
//          cell.alpha = 1
//      }
//  }
//}
