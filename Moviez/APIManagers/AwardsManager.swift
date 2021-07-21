//
//  AwardsManager.swift
//  Moviez
//
//  Created by MacBook  on 19.07.21.
//

import Foundation

protocol AwardsManagerProtocol: AnyObject {
    func fetchAwards(completion: @escaping ([Awards]) -> Void)
}

class AwardsManager: AwardsManagerProtocol {
    func fetchAwards(completion: @escaping ([Awards]) -> Void) {
        let url = APIURLS.awardsURL
        NetworkManager.shared.get(url: url) { (result: Result<[Awards], Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    completion(response)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
