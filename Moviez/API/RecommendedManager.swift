//
//  RecommendedItemsAPIManager.swift
//  Moviez
//
//  Created by MacBook  on 27.06.21.
//

import Foundation

protocol RecommendedManagerProtocol: AnyObject {
    func fetchRecommendedItems(with type: String, id: Int, completion: @escaping ([SearchModel]) -> Void)
}

class RecommendedManager: RecommendedManagerProtocol {

    func fetchRecommendedItems(with type: String, id: Int, completion: @escaping ([SearchModel]) -> Void) {
        let link = "https://api.themoviedb.org/3/\(type)/\(id)/recommendations?api_key=705f6a951803d1ed4524ef2a658cbc16&language=en-US&page=1"
        NetworkManager.shared.get(url: link) { (result: Result<SearchResponse, Error>) in
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
