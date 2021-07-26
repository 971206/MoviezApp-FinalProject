//
//  PersonDetailInfoDataSource.swift
//  Moviez
//
//  Created by MacBook  on 26.06.21.
//

import UIKit

class PersonDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var tableView: UITableView!
    private var viewModel: PersonViewModelProtocol!
    var movieCreditsList: [SearchModel]?
    var tvShowCreditsList: [SearchModel]?
    var personDetailInfo: PersonInfoViewModel?
    var id: Int?
    
    
    init(with tableView: UITableView, viewModel: PersonViewModelProtocol) {
        super.init()
        self.tableView = tableView
        self.viewModel = viewModel
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func refresh() {
        viewModel.fetchPersonDetailInfo(id: id ?? 0) { [weak self] personDetailInfo in
            guard let self = self else {return}
            self.personDetailInfo = PersonInfoViewModel(with: personDetailInfo)
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
            let cell = tableView.deque(PersonInfoCell.self, for: indexPath)
            cell.configure(with: personDetailInfo)
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.deque(BaseCell.self, for: indexPath)
            cell.configureMovieCredits(items: movieCreditsList)
            cell.personCreditsDelegate = self
            return cell
            
        }
        
        if indexPath.row == 2 {
            let cell = tableView.deque(BaseCell.self, for: indexPath)
            cell.configureTvShowCredits(items: tvShowCreditsList)
            cell.personCreditsDelegate = self
            return cell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 { return  UITableView.automaticDimension}
        
        if indexPath.row == 1 {
            return movieCreditsList?.count != 0 ? 305 : 0
        }
        if indexPath.row == 2 {
            return tvShowCreditsList?.count != 0 ? 305 : 0
        }
       
        return 0
    }
}

extension PersonDataSource: PersonCreditsDelegate {
    func onTvShowCreditsClicked(id: Int) {
        viewModel.controller.coordinator?.proceedToMovieAndTvShowDetailInfo(id: id, mediaType: MediaType.tv.rawValue)
    }
    
    func onMovieCreditsClicked(id: Int) {
        viewModel.controller.coordinator?.proceedToMovieAndTvShowDetailInfo(id: id, mediaType: MediaType.movie.rawValue)

    }
}
