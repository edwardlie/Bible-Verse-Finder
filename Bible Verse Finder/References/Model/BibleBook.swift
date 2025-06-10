//
//  BibleBook.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 5/7/25.
//

import Foundation

struct BibleBook: Decodable, Identifiable {
    let id: Int
    let bookName: String
    let numberOfChapters: Int
    let numberOfVerses: [Int]
    let recommendedAbbreviation: String
}
