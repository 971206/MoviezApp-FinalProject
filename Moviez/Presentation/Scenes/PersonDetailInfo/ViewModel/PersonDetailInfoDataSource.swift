//
//  PersonDetailInfoDataSource.swift
//  Moviez
//
//  Created by MacBook  on 26.06.21.
//

import UIKit

class PersonDetailInfoDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var tableView: UITableView!
    private var viewModel: PersonDetailInfoViewModelProtocol!
    var movieCreditsList: [SearchModel]?
    var tvShowCreditsList: [SearchModel]?
    var personDetailInfo: Person?
    var id: Int?
    
    
    init(with tableView: UITableView, viewModel: PersonDetailInfoViewModelProtocol) {
        super.init()
        self.tableView = tableView
        self.viewModel = viewModel
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func refresh() {
        viewModel.fetchPersonDetailInfo(id: id ?? 0) { [weak self] personDetailInfo in
            guard let self = self else {return}
            self.personDetailInfo = personDetailInfo
            self.tableView.reloadData()
        }
        
        viewModel.fetchMovieCredits(with: id ?? 0) { [weak self] movieCreditsList in
            self?.movieCreditsList = movieCreditsList
            self?.tableView.reloadData()
        }
        
        viewModel.fetchTVShowCredits(with: id ?? 0) { [weak self] tvShowCreditsList in
            self?.tvShowCreditsList = tvShowCreditsList
            self?.tableView.reloadData()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.row == 0 {
            let cell = tableView.deque(PersonDetailInfoCell.self, for: indexPath)
            cell.configure(with: personDetailInfo)
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.deque(SimilarCell.self, for: indexPath)
            cell.configureMovieCredits(items: movieCreditsList)
            cell.personCreditsDelegate = self
            return cell
            
        }
        
        if indexPath.row == 2 {
            let cell = tableView.deque(SimilarCell.self, for: indexPath)
            cell.configureTvShowCredits(items: tvShowCreditsList)
            cell.personCreditsDelegate = self
            return cell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 500
        }
        if indexPath.row == 1 {
            return 330
        }
        if indexPath.row == 2 {
            return 305
        }
        if indexPath.row == 3 {
            return 305
        }
        return 0
    }
}

extension PersonDetailInfoDataSource: PersonCreditsDelegate {
    func onTvShowCreditsClicked(id: Int) {
        viewModel.controller.coordinator?.proceedToMovieAndTvShowDetailInfo(id: id, type: MediaType.tv.rawValue)
    }
    
    func onMovieCreditsClicked(id: Int) {
        viewModel.controller.coordinator?.proceedToMovieAndTvShowDetailInfo(id: id, type: MediaType.movie.rawValue)

    }
}
