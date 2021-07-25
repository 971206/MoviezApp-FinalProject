//
//  NewDetailInfoDataSoure.swift
//  Moviez
//
//  Created by MacBook  on 11.07.21.
//


import UIKit
import Firebase

class DetailInfoDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    
    private var tableView: UITableView!
    
    private var navigationController: UINavigationController!
    private var viewModel: DetailInfoViewModelProtocol!
    var recommendedItemsList: [SearchModel]?
    var similarItemsList: [SearchModel]?
    let dataBase = Firestore.firestore()
    var detailInfo: MovieTvShowDetailsViewModel?
    var castList: [PersonInfo]?
    var mediaType: String?
    var id: Int?
    var descriptionCell: DescriptionCell?
    var detailInfoFetched = false
    var recomendedItemsFetched = false
    var similarItemsFetched = false
    var castInfoFetched = false
    
    
    init(with tableView: UITableView, viewModel: DetailInfoViewModelProtocol, navigationController: UINavigationController) {
        super.init()
        
        self.tableView = tableView
        self.viewModel = viewModel
        self.navigationController = navigationController
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    
    func refresh() {
        viewModel.fetchDetailInfo(id: id ?? 0, type: mediaType ?? "") { [weak self] detailInfo in
            guard let self = self else {return}
            self.detailInfo = MovieTvShowDetailsViewModel(details: detailInfo)
            self.detailInfoFetched = true
            self.reloadFetchedData()
        }
        viewModel.fetchRecommendedItems(with: mediaType ?? "", id: id ?? 0) { [weak self] recommendedItems in
            guard let self = self else {return}
            self.recommendedItemsList = recommendedItems
            self.recomendedItemsFetched = true
            self.reloadFetchedData()
        }
        viewModel.fetchSimilarItems(with: mediaType ?? "", id: id ?? 0) { [weak self] similarItems in
            guard let self = self else {return}
            self.similarItemsList = similarItems
            self.similarItemsFetched = true
            self.reloadFetchedData()
        }
        viewModel.fetchCastInfo(id: id ?? 0, type: mediaType ?? "") { [weak self] castList in
            guard let self = self else {return}
            self.castList = castList
            self.castInfoFetched = true
            self.reloadFetchedData()
        }
    }
    
    func reloadFetchedData(){
       // if castInfoFetched && similarItemsFetched && recomendedItemsFetched && detailInfoFetched {
            self.tableView.reloadData()
       // }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.row == 0 {
            let cell = tableView.deque(DescriptionCell.self, for: indexPath)
            if detailInfo != nil {
                cell.configure(with: detailInfo)
                
                cell.buttonPlayTrailer.addTarget(self, action: #selector(playTrailer), for: .touchUpInside)
                cell.addToFavoritesButton.addButton.addTarget(self, action: #selector(addToFavorites(_:)), for: .touchUpInside)
                cell.addToWatchListButton.addButton.addTarget(self, action: #selector(addToWatchlist(_:)), for: .touchUpInside)
                
                descriptionCell = cell
                return cell
            }
          
            return .init()
        }
        
        if indexPath.row == 1 {
            
            let cell = tableView.deque(SeasonCell.self, for: indexPath)
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.deque(CastCell.self, for: indexPath)
            cell.delegate = self
            cell.configureCastList(items: castList ?? [])
            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.deque(SimilarCell.self, for: indexPath)
            cell.delegate = self
            cell.configureSimilarItems(items: similarItemsList ?? [])
            return cell
        }
        if indexPath.row == 4 {
            let cell = tableView.deque(SimilarCell.self, for: indexPath)
            cell.delegate = self
            cell.configureRecommenderItems(items: recommendedItemsList ?? [])
            return cell
        }
        return cell
    }
    
    @objc func proceedToReviews() {
        viewModel.controller.coordinator?.proceetToReviews(with: id ?? 0, mediaType: mediaType ?? "")
    }
    
    @objc func addToFavorites (_ sender: Any) {
        guard let mediaType = mediaType else {return}
        guard let id = id else  {return}
        guard let detailInfo = detailInfo else {return}
        
        FirebaseHelper.saveItemInFirebaseCollection(collection:"favorites", id: id, mediaType: mediaType, movieRuntime: detailInfo.movieRuntime ?? "", tvshowRuntime: detailInfo.tvShowEpisodeRuntime ?? "", imageURL: detailInfo.imageURL ?? "", movieReleaseDate: detailInfo.movieReleaseDate ?? "", tvShowReleaseDate: detailInfo.tvShowReleaseDate ?? "", averageRate: detailInfo.averageVote ?? "", movieTitle: detailInfo.movieTitle  ?? "", tvShowTitle: detailInfo.tvShowTitle ?? "",completion: {
            self.descriptionCell?.addToWatchListButton.makeAnimation()
        })
        
    }
    @objc func addToWatchlist(_ sender: Any) {
        guard let mediaType = mediaType else {return}
        guard let id = id else  {return}
        guard let detailInfo = detailInfo else {return}
        
        FirebaseHelper.saveItemInFirebaseCollection(collection:"watchlists", id: id, mediaType: mediaType, movieRuntime: detailInfo.movieRuntime ?? "", tvshowRuntime: detailInfo.tvShowEpisodeRuntime ?? "", imageURL: detailInfo.imageURL ?? "", movieReleaseDate: detailInfo.movieReleaseDate ?? "", tvShowReleaseDate: detailInfo.tvShowReleaseDate ?? "", averageRate: detailInfo.averageVote ?? "", movieTitle: detailInfo.movieTitle  ?? "", tvShowTitle: detailInfo.tvShowTitle ?? "",completion: {
            self.descriptionCell?.addToWatchListButton.makeAnimation()
        })
    }
    
    @objc func playTrailer() {
        viewModel.controller.coordinator?.proceedToTrailer(with: mediaType ?? "", with: id ?? 0)
    }
    
    @objc func onBack() {
        viewModel.controller.coordinator?.onBack()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 { return  UITableView.automaticDimension}
        if indexPath.row == 1 && mediaType == "tv" { return 100 }
        if indexPath.row == 2 { return 305 }
        if indexPath.row == 3 { return 305 }
        if indexPath.row == 4 { return 305 }
        return 0
    }
}

extension DetailInfoDataSource: CastCellDelegate, SimilarCellDelegate {
    func onSimilarClicked(id: Int) {
        viewModel.controller.coordinator?.proceedToMovieAndTvShowDetailInfo(id: id , mediaType: mediaType ?? "")
    }
    func onRecommendedClicked(id: Int) {
        viewModel.controller.coordinator?.proceedToMovieAndTvShowDetailInfo(id: id, mediaType: mediaType ?? "")
    }
    func onCastClicked(personId: Int) {
        viewModel.controller.coordinator?.proceedToPersonDetailInfo(personId: personId, mediaType: mediaType ?? "")
    }
}

