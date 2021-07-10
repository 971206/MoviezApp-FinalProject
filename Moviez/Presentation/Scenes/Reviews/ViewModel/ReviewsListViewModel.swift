//
//  ReviewsListViewModel.swift
//  Moviez
//
//  Created by MacBook  on 11.06.21.
//

import UIKit

protocol ReviewsListViewModelProtocol: AnyObject {
    func fetchReviewsList(id: Int, type: String, completion: @escaping ([Review]) -> Void)
    init (with reviewsManager: ReviewsManagerProtocol)
}

class ReviewsListViewModel: ReviewsListViewModelProtocol {
    
    private var reviewsManager: ReviewsManagerProtocol!
    
    required init(with reviewsManager: ReviewsManagerProtocol) {
        self.reviewsManager = reviewsManager
    }
    
    func fetchReviewsList(id: Int, type: String, completion: @escaping ([Review]) -> Void) {
        reviewsManager.fetchReviewsList(id: id, type: type) { reviews in
            let reviews = reviews
            completion(reviews)
        }
    }
}
