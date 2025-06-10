//
//  LocalBibleBooksFetcher.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 5/7/25.
//

import Foundation

struct LocalBibleBooksFetcher {
    func fetchBibleBooks() throws -> [BibleBook] {
        guard let fileURL = Bundle.main.url(forResource: "BibleBooks", withExtension: "json") else {
            throw DataModelError.invalidURL
        }
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode([BibleBook].self , from: data)
    }
}
