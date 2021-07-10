//
//  SearchAPIManager.swift
//  Moviez
//
//  Created by MacBook  on 08.06.21.
//

import Foundation

protocol SearchManagerProtocol: AnyObject {
    func fetchSearchedInfo(searchText: String,page: Int, completion: @escaping ([SearchModel]) -> Void)
}

class SearchManager: SearchManagerProtocol {

    func fetchSearchedInfo(searchText: String,page: Int, completion: @escaping ([SearchModel]) -> Void) {
        var url = APIURLS.createPath(path: "/search/multi")
        url += "&query=\(searchText)"
        url += "&page=\(page)"
        if url.last == " " {
            url.dropLast()
        }
        url = url.replacingOccurrences(of: " ", with: "")
        NetworkManager.shared.get(url: url) { (result: Result<SearchResponse, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    completion(response.results ?? [])
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
