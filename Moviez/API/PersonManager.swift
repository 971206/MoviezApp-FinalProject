//
//  PersonAPIManager.swift
//  Moviez
//
//  Created by MacBook  on 01.07.21.
//

import Foundation

protocol PersonManagerProtocol: AnyObject {
    func fetchPersonDetailInfo(id: Int, completion: @escaping (PersonInfo) -> Void)
}

class PersonManager: PersonManagerProtocol {
    func fetchPersonDetailInfo(id: Int, completion: @escaping (PersonInfo) -> Void){
        let url = "https://api.themoviedb.org/3/person/\(id)?api_key=705f6a951803d1ed4524ef2a658cbc16&language=en-US"
        NetworkManager.shared.get(url: url) { (result: Result<PersonInfo, Error>) in
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

