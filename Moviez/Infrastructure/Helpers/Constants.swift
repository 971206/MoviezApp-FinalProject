//
//  Constants.swift
//  Moviez
//
//  Created by MacBook  on 05.06.21.
//

import Foundation


struct BaseURL {
    static let imageBaseURL            = "https://image.tmdb.org/t/p/w342"
    static let theMoviewDBBaseURL      = "https://api.themoviedb.org/3"
    static let apiKey                  = "705f6a951803d1ed4524ef2a658cbc16"
}

struct APIURLS {
    static func createPath(path: String) -> String {
        let path = "\(BaseURL.theMoviewDBBaseURL)\(path)?api_key=\(BaseURL.apiKey)&language=en-US"
        return path
    }
    
    static let newsURL = "https://newsapi.org/v2/everything?q=movie&apiKey=aa33cd6cf56b4ec69f1ec574996fbbf7"
    static let boxOffice = "https://imdb-api.com/en/API/BoxOffice/k_d30kcp21"
    static let movieNewsURL = "https://newsapi.org/v2/everything?q=movie&from=&sortBy=publishedAt&apiKey=aa33cd6cf56b4ec69f1ec574996fbbf7&domains=variety.com,indiewire.com,screendaily.com,theplaylist.net,slashfilm.com,theguardian.com&language=en&pageSize=20&page="
    static let celebrityNewsURL = "https://newsapi.org/v2/everything?q=celebrity&from=&sortBy=publishedAt&apiKey=aa33cd6cf56b4ec69f1ec574996fbbf7&domains=variety.com,indiewire.com,etcanada.com,screendaily.com,theplaylist.net,slashfilm.com,theguardian.com,eonline.com&language=en&pageSize=20&page="
    static let tvShowNewsURL = "https://newsapi.org/v2/everything?q=tv&from=&sortBy=publishedAt&apiKey=aa33cd6cf56b4ec69f1ec574996fbbf7&domains=variety.com,indiewire.com,tvline.com,etcanada.com,screendaily.com,theplaylist.net,slashfilm.com,theguardian.com,eonline.com,hollywoodreporter.com&language=en&pageSize=20&page="
    static let awardsURL = "https://run.mocky.io/v3/2c6ac2ae-7e31-44d4-865e-4438a019b545"
}



