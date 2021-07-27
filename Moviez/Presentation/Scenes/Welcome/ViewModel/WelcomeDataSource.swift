//
//  WelcomeDataSource.swift
//  Moviez
//
//  Created by MacBook  on 27.07.21.
//

import UIKit

class WelcomeDataSource: NSObject {
    private var collectionView: UICollectionView!
    private var viewModel: WelcomeViewModelProtocol!
    private var welcomePages = [WelcomePage]()

    var endDragging: ((Int) -> Void)?
    
    
    

    init(with collectionView: UICollectionView, viewModel: WelcomeViewModelProtocol) {
        super.init()
        self.viewModel = viewModel
        self.collectionView = collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
     
    }

    func refresh() {
        welcomePages.append(contentsOf: viewModel.welcomePages())
        collectionView.reloadData()
    }
}

extension WelcomeDataSource: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return welcomePages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(WelcomeCell.self, for: indexPath)
        cell.configure(with: welcomePages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 590)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension WelcomeDataSource: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        endDragging?(Int(x / collectionView.bounds.width))
    }
}
