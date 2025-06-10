//
//  ContainerExtension.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 5/8/25.
//

import Foundation

actor AppData {
    static let shared = AppData()
    var bibleBooks: [BibleBook] = []

    private init() {}
    
    func fetchBibleBooks() throws -> [BibleBook] {
        if bibleBooks.isEmpty {
            do {
                return try LocalBibleBooksFetcher().fetchBibleBooks()
            } catch {
                throw DataModelError.unknown
            }
        } else {
            return bibleBooks
        }
    }
}
