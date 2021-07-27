//
//  SearchDataSource.swift
//  Moviez
//
//  Created by MacBook  on 08.06.21.
//

import UIKit

class SearchDataSource: NSObject {
    
 //MARK: - Private Properties
    private var tableView: UITableView!
    private var viewModel: SearchListViewModelProtocol!
    private var searchBar: UISearchBar!
    private var searchResult: [SearchModel]?
    private var searchListVC: SearchListViewController?
    private var isFetchigMoreData = false
    private var isPagingDone = false
    private var pageSize = 20
    private var page = 1
    
    //MARK: - Init
    init(with tableView: UITableView, viewModel: SearchListViewModelProtocol, searchBar: UISearchBar,vc: SearchListViewController) {
        super.init()
        self.tableView = tableView
        self.viewModel = viewModel
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchBar = searchBar
        self.searchListVC = vc
    }
    
    // MARK: - Search
    func search(with text: String) {
        isPagingDone = false
        isFetchigMoreData = false
        viewModel.getSearchResult(searchText: text,page: 1) { [weak self] searchResult in
            guard let self = self else {return}
            self.searchResult = searchResult
            self.isPagingDone = searchResult.count != self.pageSize
            self.searchListVC?.view.stopLoading()
            self.tableView.reloadData()
        }
    }
    
    func searchMore(with text: String) {
        guard isPagingDone == false && isFetchigMoreData == false else { return }
        isFetchigMoreData = true
        page += 1
        viewModel.getSearchResult(searchText: text, page: page) { [weak self] searchResult in
            guard let self = self else {return}
            self.searchResult?.append(contentsOf: searchResult)
            self.isPagingDone = searchResult.count != self.pageSize
            self.isFetchigMoreData = false
            self.tableView.reloadData()
        }
    }
}
    
//MARK: - TableView DataSource
    
extension SearchDataSource: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResult?.count == 0 || searchResult == nil { return 1 }
        return searchResult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchResult?.count == 0 || searchResult == nil {
            let cell = tableView.deque(EmptyCell.self, for: indexPath)
            return cell
        }
        let cell = tableView.deque(SearchResultCell.self, for: indexPath)
        cell.configure(with: searchResult?[indexPath.row])
        if indexPath.row == (searchResult?.count ?? 0) - 1 {
            searchMore(with: viewModel.searchedText ?? "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard searchResult?.count != 0 else { return }
        guard let result = searchResult?[indexPath.row] else { return }
        let choosedItemsMediaType = result.mediaType
        
        if choosedItemsMediaType == MediaType.movie.rawValue  {
            viewModel.controller.coordinator?.proceedToDetailsFromSearchMovieAndTvShowChoosed(with: result)

        } else if choosedItemsMediaType == MediaType.tv.rawValue  {
            viewModel.controller.coordinator?.proceedToDetailsFromSearchMovieAndTvShowChoosed(with: result)
        } else {
            viewModel.controller.coordinator?.proceedToDetailsFromSearchWhenPersonChoosed(with: result)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if searchResult?.count == 0 || searchResult == nil {
            return 500
        } else {
            return 108
        }
    }
    
}


