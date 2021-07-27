//
//  DetailInfoViewModel.swift
//  Moviez
//
//  Created by MacBook  on 11.06.21.
//

import UIKit


protocol DetailInfoViewModelProtocol: AnyObject {
    
    func fetchSimilarItems(with type: String, id: Int, completion: @escaping ([SearchModel]) -> Void)
    func fetchRecommendedItems(with type: String, id: Int, completion: @escaping ([SearchModel]) -> Void)
    func fetchDetailInfo(id: Int,type: String, completion: @escaping (MovieTvShowDetails) -> Void)
    func fetchCastInfo(id: Int, type: String, completion: @escaping ([PersonInfo]) -> Void)
    var controller: CoordinatorDelegate { get }

    
    
    init(with similarItemsManager: SimilarItemsManagerProtocol,
         with recommendedItemsManager: RecommendedManagerProtocol,
         with detailsManager: DetailsManagerProtocol,
         with castManager: CastManagerProtocol,
         with controller: CoordinatorDelegate)
}

class DetailInfoViewModel: DetailInfoViewModelProtocol {
    
    private var similarItemsManager: SimilarItemsManagerProtocol!
    private var detailsManager: DetailsManagerProtocol!
    private var recommendedItemsManager: RecommendedManagerProtocol!
    private var castManager: CastManagerProtocol!
    private var detailInfo: MovieTvShowDetails?
    private var similarItems: [SearchModel]?
    private var recommendedItems: [SearchModel]?
    private(set) var controller: CoordinatorDelegate

    
    
    
    required init(with similarItemsManager: SimilarItemsManagerProtocol,
                  with recommendedItemsManager: RecommendedManagerProtocol,
                  with detailsManager: DetailsManagerProtocol,
                  with castManager: CastManagerProtocol,
                  with controller: CoordinatorDelegate) {
        self.similarItemsManager = similarItemsManager
        self.detailsManager = detailsManager
        self.recommendedItemsManager = recommendedItemsManager
        self.castManager = castManager
        self.controller = controller
    }
    
    // MARK: - Fetch Info
    func fetchCastInfo(id: Int, type: String, completion: @escaping ([PersonInfo]) -> Void) {
        castManager.fetchCastInfo(id: id, type: type) { castList in
            completion(castList)
        }
    }
    
    func fetchDetailInfo(id: Int, type: String, completion: @escaping (MovieTvShowDetails) -> Void) {
        detailsManager.fetchDetailInfo(id: id, type: type) {detailInfo in
            completion(detailInfo)
        }
    }
    
    func fetchSimilarItems(with type: String, id: Int, completion: @escaping ([SearchModel]) -> Void) {
        similarItemsManager.fetchSimilarItems(with: type, id: id) {similarItems in
            completion(similarItems)
        }
    }
    
    func fetchRecommendedItems(with type: String, id: Int, completion: @escaping ([SearchModel]) -> Void) {
        recommendedItemsManager.fetchRecommendedItems(with: type, id: id) {recommendedItems in
            completion(recommendedItems)
        }
    }
    
}
