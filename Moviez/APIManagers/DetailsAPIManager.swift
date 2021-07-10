//
//  DetailsAPIManager.swift
//  Moviez
//
//  Created by MacBook  on 12.06.21.
//

import Foundation

protocol DetailsManagerProtocol: AnyObject {
    func fetchDetailInfo(id: Int, type: String, completion: @escaping (Details) -> Void)
}

class DetailsManager: DetailsManagerProtocol {
    
    func fetchDetailInfo(id: Int, type: String, completion: @escaping (Details) -> Void) {
        let url = APIURLS.createPath(path: "/\(type)/\(id)")
        NetworkManager.shared.get(url: url) { (result: Result<Details, Error>) in
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
