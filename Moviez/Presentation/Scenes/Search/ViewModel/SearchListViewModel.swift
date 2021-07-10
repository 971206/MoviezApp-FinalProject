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
    func proceedToDetailsMovieAndTvShowChoosed(with id : SearchModel)
    func proceedToDetailsWhenPersonChoosed(with item: SearchModel) 
    func getSearchResult(searchText: String,page: Int, completion: @escaping (([SearchModel]) -> Void))
    init(with searchManager: SearchManagerProtocol, navigationController: UINavigationController?)
}

class SearchListViewModel: SearchListViewModelProtocol {
    
    //MARK: - Private Properties
    private var searchManager: SearchManagerProtocol!
    private var searchItems:[SearchModel]?
    private var navigationController: UINavigationController?
    var searchedText: String?
    
    //MARK: - Internal Properties
    var searchBar: UISearchBar?
    
    //MARK: - Init
    required init(with searchManager: SearchManagerProtocol, navigationController: UINavigationController?) {
        self.searchManager = searchManager
        self.navigationController = navigationController
    }
    
    //MARK: - Get Search Result
    func getSearchResult(searchText: String,page: Int, completion: @escaping (([SearchModel]) -> Void)) {
        searchedText = searchText
        searchManager.fetchSearchedInfo(searchText: searchText,page: page) { searchResult in
            completion(searchResult)
        }
    }
    
    func proceedToDetailsMovieAndTvShowChoosed(with item : SearchModel) {
        let sb = UIStoryboard(name: VCIds.detailInfoVC, bundle: nil)
        let detailsInfoVC = sb.instantiateViewController(withIdentifier: VCIds.detailInfoVC) as! DetailInfoViewController
        detailsInfoVC.idOfItem = item.id
        detailsInfoVC.typeOfItem = item.mediaType
        self.navigationController?.pushViewController(detailsInfoVC, animated: true)
    }
    
    func proceedToDetailsWhenPersonChoosed(with item: SearchModel) {
        let sb = UIStoryboard(name: VCIds.personDetailInfoVC, bundle: nil)
        let detailsInfoVC = sb.instantiateViewController(withIdentifier: VCIds.personDetailInfoVC) as! PersonDetailInfoViewController
        detailsInfoVC.id = item.id
        detailsInfoVC.mediaType = item.mediaType
        self.navigationController?.pushViewController(detailsInfoVC, animated: true)
    }
}
