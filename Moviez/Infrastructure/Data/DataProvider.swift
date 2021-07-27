//
//  DataProvider.swift
//  Moviez
//
//  Created by MacBook  on 27.07.21.
//

import Foundation

final class DataProvider {
    static func fetchData<T: Codable>(fileName: String) -> T? {
        guard let url = Bundle.main.url(forResource: "\(fileName).json", withExtension: nil) else {fatalError()}
        guard let contents = try? Data(contentsOf: url) else {fatalError()}
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: contents)
        } catch {
            print("error")
        }
        fatalError()
    }
}

