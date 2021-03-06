//
//  NewDetailInfoDataSource.swift
//  Moviez
//
//  Created by MacBook  on 30.06.21.
//

import UIKit

class DetailInfoDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
   

    private var tableView: UITableView!
    
    private var navigationController: UINavigationController!
    private var viewModel: DetailInfoViewModelProtocol!
    var recommendedItemsList: [SearchModel]?
    var similarItemsList: [SearchModel]?
    var detailInfo: Details?
    var castList: [Person]?
    var type: String?
    var id: Int?
    
    init(with tableView: UITableView, viewModel: DetailInfoViewModelProtocol, navigationController: UINavigationController) {
        super.init()
        self.tableView = tableView
        self.viewModel = viewModel
        self.navigationController = navigationController
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    
    func refresh() {
        viewModel.fetchDetailInfo(id: id ?? 0, type: type ?? "") { [weak self] detailInfo in
            guard let self = self else {return}
            self.detailInfo = detailInfo
            self.tableView.reloadData()
        }
        viewModel.fetchRecommendedItems(with: type ?? "", id: id ?? 0) { [weak self] recommendedItems in
            guard let self = self else {return}
            self.recommendedItemsList = recommendedItems
            self.tableView.reloadData()
        }
        viewModel.fetchSimilarItems(with: type ?? "", id: id ?? 0) { [weak self] similarItems in
            guard let self = self else {return}
            self.similarItemsList = similarItems
            self.tableView.reloadData()
        }
        viewModel.fetchCastInfo(id: id ?? 0, type: type ?? "") { [weak self] castList in
            guard let self = self else {return}
            self.castList = castList
            self.tableView.reloadData()

        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.row == 0 {
            let cell = tableView.deque(MovieAndTvShowDescriptionCell.self, for: indexPath)
            cell.configure(with: detailInfo)
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.deque(CastCell.self, for: indexPath)
            cell.delegate = self
            cell.configureCastList(items: castList ?? [])
            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.deque(SimilarCell.self, for: indexPath)
            cell.delegate = self
            cell.configureSimilarItems(items: similarItemsList ?? [])
            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.deque(SimilarCell.self, for: indexPath)
            cell.delegate = self
            cell.configureRecommenderItems(items: recommendedItemsList ?? [])
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 500
        }
        if indexPath.row == 1 {
            return 330
        }
        if indexPath.row == 2 {
            return 305
        }
        
        if indexPath.row == 3 {
            return 305
        }
        return 0
    }
}

extension DetailInfoDataSource: CastCellDelegate, SimilarCellDelegate {
    
    func onSimilarClicked(id: Int) {
        let sb = UIStoryboard(name: VCIds.detailInfoVC, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: VCIds.detailInfoVC) as! DetailInfoViewController
        vc.idOfItem = id
        vc.typeOfItem = type
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func onRecommendedClicked(id: Int) {
        let sb = UIStoryboard(name: VCIds.detailInfoVC, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: VCIds.detailInfoVC) as! DetailInfoViewController
        vc.idOfItem = id
        vc.typeOfItem = type
        self.navigationController.pushViewController(vc, animated: true)
    }
    

    func onCastClicked(personId: Int) {
        let sb = UIStoryboard(name: VCIds.personDetailInfoVC, bundle: nil)
        let vc = sb.instantiateViewController(identifier: VCIds.personDetailInfoVC) as! PersonDetailInfoViewController
        vc.id = personId
        vc.mediaType = type
        self.navigationController.pushViewController(vc, animated: true)

    }
    
}
