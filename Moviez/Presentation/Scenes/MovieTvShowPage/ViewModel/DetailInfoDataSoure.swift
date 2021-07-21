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
    var detailInfo: Details?
    var castList: [Person]?
    var mediaType: String?
    var id: Int?
    
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
            self.detailInfo = detailInfo
            self.tableView.reloadData()
        }
        viewModel.fetchRecommendedItems(with: mediaType ?? "", id: id ?? 0) { [weak self] recommendedItems in
            guard let self = self else {return}
            self.recommendedItemsList = recommendedItems
            self.tableView.reloadData()
        }
        viewModel.fetchSimilarItems(with: mediaType ?? "", id: id ?? 0) { [weak self] similarItems in
            guard let self = self else {return}
            self.similarItemsList = similarItems
            self.tableView.reloadData()
        }
        viewModel.fetchCastInfo(id: id ?? 0, type: mediaType ?? "") { [weak self] castList in
            guard let self = self else {return}
            self.castList = castList
            self.tableView.reloadData()
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.row == 0 {
            let cell = tableView.deque(NewDescriptionCell.self, for: indexPath)
//            cell.butt.addTarget(self, action: #selector(proceedToReviews), for: .touchUpInside)
            cell.buttonPlayTrailer.addTarget(self, action: #selector(playTrailer), for: .touchUpInside)
            cell.buttonAddFavorites.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
            cell.buttonAddWatchlist.addTarget(self, action: #selector(addToWatchlist), for: .touchUpInside)
            cell.onBack.addTarget(self, action: #selector(onBack), for: .touchUpInside)

            
            cell.configure(with: detailInfo)
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.deque(CastCell.self, for: indexPath)
            cell.delegate = self
            cell.configureCastList(items: castList ?? [])
            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.deque(SimilarCell.self, for: indexPath)
            cell.delegate = self
            cell.configureSimilarItems(items: similarItemsList ?? [])
            return cell
        }
        if indexPath.row == 3 {
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
    
    @objc func addToFavorites () {
        guard let mediaType = mediaType else {return}
        guard let id = id else  {return}
        guard let userID = Auth.auth().currentUser?.uid else { return }
        guard let detailInfo = detailInfo else {return}
        dataBase.collection(userID).addDocument(data: ["collection" : "favorites",
                                                       "mediaType" : mediaType,
                                                       "id" : id,
                                                       "movieRuntime": detailInfo.runtime ?? 0,
                                                       "tvshowRuntime": detailInfo.episodeRunTime ?? 0,
                                                       "imageURL" : detailInfo.posterURL ?? "",
                                                       "movieReleaseDate" : detailInfo.releaseDate ?? "",
                                                       "tvShowReleaseDate" : detailInfo.firstAirDate ?? "",
                                                       "averageRate" : detailInfo.voteAverage ?? "",
                                                       "movieTitle" : detailInfo.nameMovie ?? "",
                                                       "tvShowTitle" : detailInfo.nameTvShow ?? ""])
        
    }
    @objc func addToWatchlist() {
        guard let mediaType = mediaType else {return}
        guard let id = id else  {return}
        guard let userID = Auth.auth().currentUser?.uid else { return }
        guard let detailInfo = detailInfo else {return}
        dataBase.collection(userID).addDocument(data: ["collection" : "watchlist",
                                                       "mediaType" : mediaType,
                                                       "id" : id,
                                                       "imageURL" : detailInfo.posterURL ?? "",
                                                       "movieRuntime": detailInfo.runtime ?? 0,
                                                       "tvshowRuntime": detailInfo.episodeRunTime ?? 0,
                                                       "movieReleaseDate" : detailInfo.releaseDate ?? "",
                                                       "tvShowReleaseDate" : detailInfo.firstAirDate ?? "",
                                                       "averageRate" : detailInfo.voteAverage ?? "",
                                                       "movieTitle" : detailInfo.nameMovie ?? "",
                                                       "tvShowTitle" : detailInfo.nameTvShow ?? ""])

        
    }
    
    @objc func playTrailer() {
        print("play")
        viewModel.controller.coordinator?.proceedToTrailer(with: mediaType ?? "", with: id ?? 0)
    }
    
    @objc func onBack() {
        viewModel.controller.coordinator?.onBack()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 { return  UITableView.automaticDimension}
        if indexPath.row == 1 { return 330 }
        if indexPath.row == 2 { return 305 }
        if indexPath.row == 3 { return 305 }
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
