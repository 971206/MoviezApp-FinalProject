//
//  TrendingTvShowsCell.swift
//  Moviez
//
//  Created by MacBook  on 07.06.21.
//

import UIKit

protocol HomePageCellDelegate: AnyObject {
    func onTrendingTvShowClicked(tvShow: TvShowViewModel)
    func onTrendingMoviesClicked(movie: MoviesViewModel)
    func onComingSoonClicked(movie: MoviesViewModel)
    func onInTheatersClicked(movie: MoviesViewModel)
}


class HomePageCell: UITableViewCell {
    @IBOutlet weak var labelSectionHeader: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Private Properties
    private var apiManagerOfTrendingTvShows: TrendingTvShowsManagerProtocol!
    private var apiManagerOfTrendingMovies: TrendingMoviesManagerProtocol!
    private var apiManagerOfComingSoon: ComingSoonManagerProtocol!
    private var apiManagerOfInTheaters: InTheatersManagerProtocol!
    private var listOfTrendingTvShows: [TvShowViewModel]?
    private var listOfTrendingMovies: [MoviesViewModel]?
    private var listoOfComingSoon: [MoviesViewModel]?
    private var listOfInTheaters: [MoviesViewModel]?
    
    //MARK: - Local Properties
    weak var homePageCellDelegate: HomePageCellDelegate?
    
    var collectionViewOffset: CGFloat {
        get {
            return collectionView.contentOffset.x
        }
        set {
            collectionView.contentOffset.x = newValue
        }
    }
//MARK: - VC Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }
    
// MARK: Setup CollectionView
     func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.registerNib(class: HomePageItem.self)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 307)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
    }
    
    //MARK: - FetchInfo
    
    func configureTrendingTvShows(items: [TvShowViewModel]) {
        listOfTrendingTvShows = items
        self.collectionView.reloadData()
        self.listOfTrendingMovies = nil
        self.listOfInTheaters = nil
        self.listoOfComingSoon = nil
    }
    func configureTrendingMovies(items: [MoviesViewModel]) {
        listOfTrendingMovies = items
        self.collectionView.reloadData()
        self.listOfTrendingTvShows = nil
        self.listOfInTheaters = nil
        self.listoOfComingSoon = nil
    }
    func configureInTheaters(items: [MoviesViewModel]) {
        listOfInTheaters = items
        self.collectionView.reloadData()
        self.listOfTrendingMovies = nil
        self.listOfTrendingTvShows = nil
        self.listoOfComingSoon = nil
    }
    func configureComingSoon(items: [MoviesViewModel]) {
        listoOfComingSoon = items
        self.collectionView.reloadData()
        self.listOfTrendingMovies = nil
        self.listOfInTheaters = nil
        self.listOfTrendingTvShows = nil
    }
        
}

//MARK: - CollectionView Datasource and Delegate

extension HomePageCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let item = listOfTrendingMovies { return item.count }
        if let item = listOfTrendingTvShows { return item.count }
        if let item = listOfInTheaters { return item.count }
        if let item = listoOfComingSoon { return item.count }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(HomePageItem.self, for: indexPath)
        if let tvShow = listOfTrendingTvShows?[indexPath.row] {
            cell.configure(with: tvShow)
            labelSectionHeader.text = "Tv Shows"
        }
        if let movie = listOfTrendingMovies?[indexPath.row] {
            cell.configureMovie(with: movie)
            labelSectionHeader.text = "Movies"

        }
        if let commingSoon = listoOfComingSoon?[indexPath.row] {
            cell.configureMovie(with: commingSoon)
            labelSectionHeader.text = "Coming Soon"

        }
        if let inTheaters = listOfInTheaters?[indexPath.row] {
            cell.configureMovie(with: inTheaters)
            labelSectionHeader.text = "In Theaters"

        }
        return cell
    }
    
    
}
    
extension HomePageCell: UICollectionViewDelegate {
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
        if let tvShow = listOfTrendingTvShows?[indexPath.row] {
            homePageCellDelegate?.onTrendingTvShowClicked(tvShow: tvShow)
        }
        if let movie = listOfTrendingMovies?[indexPath.row] {
            homePageCellDelegate?.onTrendingMoviesClicked(movie: movie)
        }
        if let movie = listoOfComingSoon?[indexPath.row] {
            homePageCellDelegate?.onComingSoonClicked(movie: movie)
        }
        if let movie = listOfInTheaters?[indexPath.row] {
            homePageCellDelegate?.onInTheatersClicked(movie: movie)
        }
        
    }
    
     func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       cell.alpha = 0
       UIView.animate(withDuration: 0.6) {
           cell.alpha = 1
       }
   }
}

