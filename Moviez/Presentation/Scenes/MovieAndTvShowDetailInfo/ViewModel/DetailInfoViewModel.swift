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
    func fetchDetailInfo(id: Int,type: String, completion: @escaping (Details) -> Void)
    func fetchCastInfo(id: Int, type: String, completion: @escaping ([Person]) -> Void)
    func proceedToDetailsWhenTvShowSelected(with item : SearchModel)
    func proceedToDetailsWhenMovieSelected(with item : SearchModel)
    
    init(with similarItemsManager: SimilarItemsManagerProtocol, with recommendedItemsManager: RecommendedApiManagerProtocol, with detailsManager: DetailsManagerProtocol, with castManager: CastManagerProtocol, with navigationController: UINavigationController)
}

class DetailInfoViewModel: DetailInfoViewModelProtocol {
    
    private var similarItemsManager: SimilarItemsManagerProtocol!
    private var detailsManager: DetailsManagerProtocol!
    private var recommendedItemsManager: RecommendedApiManagerProtocol!
    private var castManager: CastManagerProtocol!
    private var navigationController: UINavigationController?
    private var detailInfo: Details?
    private var similarItems: [SearchModel]?
    private var recommendedItems: [SearchModel]?
    
    
    required init(with similarItemsManager: SimilarItemsManagerProtocol, with recommendedItemsManager: RecommendedApiManagerProtocol, with detailsManager: DetailsManagerProtocol, with castManager: CastManagerProtocol, with navigationController: UINavigationController) {
        self.similarItemsManager = similarItemsManager
        self.detailsManager = detailsManager
        self.recommendedItemsManager = recommendedItemsManager
        self.castManager = castManager
        self.navigationController = navigationController
    }
    
    // MARK: - Fetch Info
    func fetchCastInfo(id: Int, type: String, completion: @escaping ([Person]) -> Void) {
        castManager.fetchCastInfo(id: id, type: type) { castList in
            completion(castList)
        }
    }
    
    func fetchDetailInfo(id: Int, type: String, completion: @escaping (Details) -> Void) {
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
    
    //MARK: - Show Details
    func proceedToDetailsWhenTvShowSelected(with item : SearchModel) {
        let sb = UIStoryboard(name: VCIds.detailInfoVC, bundle: nil)
        let detailsInfoVC = sb.instantiateViewController(withIdentifier: VCIds.detailInfoVC) as! DetailInfoViewController
        detailsInfoVC.idOfItem = item.id
        detailsInfoVC.typeOfItem = MediaType.tv.rawValue
        self.navigationController?.pushViewController(detailsInfoVC, animated: true)
    }
    
    func proceedToDetailsWhenMovieSelected(with item : SearchModel) {
        let sb = UIStoryboard(name: VCIds.detailInfoVC, bundle: nil)
        let detailsInfoVC = sb.instantiateViewController(withIdentifier: VCIds.detailInfoVC) as! DetailInfoViewController
        detailsInfoVC.idOfItem = item.id
        detailsInfoVC.typeOfItem = MediaType.movie.rawValue
        self.navigationController?.pushViewController(detailsInfoVC, animated: true)
    }
}
