//
//  SearchListViewModel.swift
//  Moviez
//
//  Created by MacBook  on 08.06.21.
//

import UIKit

protocol SearchListViewModelProtocol: AnyObject {
    var searchBar: UISearchBar? { get set }
    var searchedText: String? { get set }
    func getSearchResult(searchText: String,page: Int, completion: @escaping (([SearchModel]) -> Void))
    var controller: CoordinatorDelegate { get }
//    var tabBarDelegate: TabBarViewControllerDelegate { get set }

    init(with searchManager: SearchManagerProtocol, navigationController: UINavigationController?, controller: CoordinatorDelegate)
}

class SearchListViewModel: SearchListViewModelProtocol {

    //MARK: - Private Properties
    private var searchManager: SearchManagerProtocol!
    private var searchItems:[SearchModel]?
    private var navigationController: UINavigationController?
    var searchedText: String?
    
    private(set) var controller: CoordinatorDelegate
//    var tabBarDelegate: TabBarViewControllerDelegate

    
    //MARK: - Internal Properties
    var searchBar: UISearchBar?
    
    //MARK: - Init
    required init(with searchManager: SearchManagerProtocol, navigationController: UINavigationController?, controller: CoordinatorDelegate) {
        
        self.searchManager = searchManager
        self.navigationController = navigationController
        self.controller = controller
//        self.tabBarDelegate = tabBarDelegate
    }
    
    //MARK: - Get Search Result
    func getSearchResult(searchText: String,page: Int, completion: @escaping (([SearchModel]) -> Void)) {
        searchedText = searchText
        searchManager.fetchSearchedInfo(searchText: searchText,page: page) { searchResult in
            completion(searchResult)
        }
    }
}
