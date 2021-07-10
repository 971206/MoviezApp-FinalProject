//
//  BoxOfficeAPIManager.swift
//  Moviez
//
//  Created by MacBook  on 07.06.21.
//

import Foundation

protocol BoxOfficeManagerProtocol: AnyObject {
    func fetchBoxOfficeInfo(completion: @escaping ([BoxOffice]) -> Void)
}

class BoxOfficeManager: BoxOfficeManagerProtocol {

    func fetchBoxOfficeInfo(completion: @escaping ([BoxOffice]) -> Void) {
        let url = APIURLS.boxOffice
        NetworkManager.shared.get(url: url) { (result: Result<BoxOfficeResponse, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    completion(response.items ?? [])
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
