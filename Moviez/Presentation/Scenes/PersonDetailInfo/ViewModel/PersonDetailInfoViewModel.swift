//
//  PersonDetailInfoViewModel.swift
//  Moviez
//
//  Created by MacBook  on 26.06.21.
//

import UIKit

protocol PersonDetailInfoViewModelProtocol: AnyObject {
    func fetchPersonDetailInfo(id: Int, completion: @escaping (Person) -> Void)
    func fetchMovieCredits(with PersonId: Int, completion: @escaping ([SearchModel]) -> Void)
    func fetchTVShowCredits(with PersonId: Int, completion: @escaping ([SearchModel]) -> Void)
    init(with personManager: PersonManagerProtocol, personCreditsManager: PersonCreditsManagerProtocol )
}

final class PersonDetailInfoViewModel: PersonDetailInfoViewModelProtocol {
    private var personManager: PersonManagerProtocol!
    private var personCreditsManager: PersonCreditsManagerProtocol!
    private var personDetailInfo: Person?
    private var personMovieCredits: [SearchModel]?
    private var personTvShowCredits: [SearchModel]?
    
     init(with personManager: PersonManagerProtocol, personCreditsManager: PersonCreditsManagerProtocol) {
        self.personManager = personManager
        self.personCreditsManager = personCreditsManager
    }
    
    func fetchPersonDetailInfo(id: Int, completion: @escaping (Person) -> Void) {
        personManager.fetchPersonDetailInfo(id: id) { personDetailInfo in
            completion(personDetailInfo)
        }
    }
    
    func fetchMovieCredits(with PersonId: Int, completion: @escaping ([SearchModel]) -> Void) {
        personCreditsManager.fetchMovieCredits(with: PersonId) {  personMovieCredits in
            completion(personMovieCredits)
        }
    }
    
    func fetchTVShowCredits(with PersonId: Int, completion: @escaping ([SearchModel]) -> Void) {
        personCreditsManager.fetchTVShowCredits(with: PersonId) { personTVShowCredits in
            completion(personTVShowCredits)
        }
    }

}
