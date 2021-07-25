//
//  ReviewsAPIManager.swift
//  Moviez
//
//  Created by MacBook  on 11.06.21.
//

import Foundation

protocol ReviewsManagerProtocol: AnyObject {
    func fetchReviewsList(id: Int, type: String, completion: @escaping ([Review]) -> Void)}

class ReviewsManager: ReviewsManagerProtocol {
     
    func fetchReviewsList(id: Int, type: String, completion: @escaping ([Review]) -> Void) {
        let url = "https://api.themoviedb.org/3/\(type)/\(id)/reviews?api_key=705f6a951803d1ed4524ef2a658cbc16&language=en-US&page=1"
        NetworkManager.shared.get(url: url) { (result: Result<ReviewRespone, Error>) in
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
