//
//  PersonDetailInfoViewModel.swift
//  Moviez
//
//  Created by MacBook  on 26.06.21.
//

import UIKit

protocol PersonViewModelProtocol: AnyObject {
    func fetchPersonDetailInfo(id: Int, completion: @escaping (PersonInfo) -> Void)
    func fetchMovieCredits(with PersonId: Int, completion: @escaping ([SearchModel]) -> Void)
    func fetchTVShowCredits(with PersonId: Int, completion: @escaping ([SearchModel]) -> Void)
    var controller: CoordinatorDelegate { get }

    init(with personManager: PersonManagerProtocol, personCreditsManager: PersonCreditsManagerProtocol, controller: CoordinatorDelegate )
}

final class PersonViewModel: PersonViewModelProtocol {
    private var personManager: PersonManagerProtocol!
    private var personCreditsManager: PersonCreditsManagerProtocol!
    private var personDetailInfo: PersonInfo?
    private var personMovieCredits: [SearchModel]?
    private var personTvShowCredits: [SearchModel]?
    private(set) var controller: CoordinatorDelegate

    
    init(with personManager: PersonManagerProtocol, personCreditsManager: PersonCreditsManagerProtocol, controller: CoordinatorDelegate) {
        self.personManager = personManager
        self.personCreditsManager = personCreditsManager
        self.controller = controller
    }
    
    func fetchPersonDetailInfo(id: Int, completion: @escaping (PersonInfo) -> Void) {
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
