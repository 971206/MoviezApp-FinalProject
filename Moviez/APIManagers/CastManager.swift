//
//  CastAPIManager.swift
//  Moviez
//
//  Created by MacBook  on 27.06.21.
//

import Foundation

protocol CastManagerProtocol: AnyObject {
    func fetchCastInfo(id: Int, type: String, completion: @escaping ([Person]) -> Void)
}

class CastManager: CastManagerProtocol {
    func fetchCastInfo(id: Int, type: String, completion: @escaping ([Person]) -> Void) {
        let url = "https://api.themoviedb.org/3/\(type)/\(id)/credits?api_key=705f6a951803d1ed4524ef2a658cbc16&language=en-US"
        NetworkManager.shared.get(url: url) { (result: Result<CastResponse, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    completion(response.cast ?? [])
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
