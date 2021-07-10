//
//  CoordinatorProtocol.swift
//  Moviez
//
//  Created by MacBook  on 10.07.21.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var inTheatersManager: InTheatersManagerProtocol {get}
    var trendingMoviesManager: TrendingMoviesManagerProtocol {get}
    var trendingTvShowsManager: TrendingTvShowsManagerProtocol {get}
    var comingSoonManager: ComingSoonManagerProtocol {get}
    
    init(_ window: UIWindow?, navigationController: UINavigationController?)
    
    func start()
  
}
