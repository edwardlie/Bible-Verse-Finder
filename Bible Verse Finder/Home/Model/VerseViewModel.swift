//
//  ViewModel.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 7/5/23.
//

import Foundation

class VerseViewModel: Identifiable, ObservableObject {
    let id: UUID
    let ref: String
    let text: String
    
    init(verse: Verse) {
        self.id = verse.id
        self.ref = verse.ref
        self.text = verse.text
    }
    
    var shareText: String {
        "\(ref) \(text)"
    }
}
