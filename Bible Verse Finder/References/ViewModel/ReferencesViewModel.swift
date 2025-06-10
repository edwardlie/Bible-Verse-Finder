//
//  ReferencesViewModel.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 5/7/25.
//

import Foundation
import Observation

@Observable @MainActor
final class ReferencesViewModel {
    var bibleBooks: [BibleBook] = []
    private(set) var isFetching: Bool = true
    var error: DataModelError?
    
    func fetchBibleBooks() {
        Task {
            do {
                bibleBooks = try await AppData.shared.fetchBibleBooks()
            } catch {
                if let dataModelError = error as? DataModelError {
                    self.error = dataModelError
                } else {
                    self.error = DataModelError.unknown
                }
            }
        }
    }
}
