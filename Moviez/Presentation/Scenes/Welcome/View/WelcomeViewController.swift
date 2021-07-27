//
//  WelcomeViewController.swift
//  Moviez
//
//  Created by MacBook  on 27.07.21.
//

import UIKit

class WelcomeViewController: BaseViewController {
    
    //MARK: - IBoutlets
    
    @IBOutlet weak var buttonSkip: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageIndicator: UIPageControl!
    
    //MARK: - Private Properties
    
    private var dataSource: WelcomeDataSource!
    private var viewModel: WelcomeViewModel!
    private var lastPage = 3
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupLayout()
        configureViewModel()
        configurePageControl()
    }
    
    private func setupButton() {
        buttonSkip.layer.cornerRadius = 8
        buttonSkip.clipsToBounds = true
    }
    
    private func setupLayout() {
        collectionView.registerNib(class: WelcomeCell.self)
    }
    
    
    
    private func configureViewModel() {
        viewModel = WelcomeViewModel()
        dataSource = WelcomeDataSource(with: collectionView, viewModel: viewModel)
        dataSource.refresh()
        dataSource.endDragging = { [weak self] index in
            self?.pageIndicator.currentPage = index
            if self?.lastPage == index {
                self?.buttonSkip.setTitle("Done", for: .normal)
            } else {
                self?.buttonSkip.setTitle("Skip", for: .normal)
            }
        }
    }
    
    
    private func configurePageControl() {
        pageIndicator.numberOfPages = viewModel.numberOfPages
    }
    
    
    @IBAction func onSkip(_ sender: Any) {
        coordinator?.proceedToTabBar()
    }
}
