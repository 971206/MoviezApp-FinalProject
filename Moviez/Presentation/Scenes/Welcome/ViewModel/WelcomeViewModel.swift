//
//  WelcomeViewModel.swift
//  Moviez
//
//  Created by MacBook  on 27.07.21.
//

import Foundation

protocol WelcomeViewModelProtocol: AnyObject {
    func welcomePages() -> [WelcomePage]
    var numberOfPages: Int { get set }
}

final class WelcomeViewModel: WelcomeViewModelProtocol {
  
    var numberOfPages: Int = 0
    
    func welcomePages() -> [WelcomePage] {
        let pages: [WelcomePage] = DataProvider.fetchData(fileName: "welcomePages") ?? []
        numberOfPages = pages.count
        return pages
    }
}
