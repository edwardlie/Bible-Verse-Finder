//
//  VerseOfTheDayViewModel.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 5/7/25.
//

import Foundation

@MainActor
class VerseOfTheDayViewModel: ObservableObject {
    @Published var verses: [VerseViewModel] = []
    @Published var verseListViewModel = VerseListViewModel()
    
    func fetchVerseOfTheDay() async {
        await verseListViewModel.getVerses()
        await MainActor.run {
            self.verses = verseListViewModel.verses
        }
    }
    
    var verseOfTheDayText: String {
        if !verses.isEmpty {
            return "\(verseListViewModel.verses[0].ref) \(verseListViewModel.verses[0].text)"
        } else {
            return "No verses found..."
        }
    }
}
