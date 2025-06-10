//
//  VerseListViewModel.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 5/9/25.
//

import Foundation

@MainActor
class VerseListViewModel: ObservableObject {
    
    @Published var model: Model?
    @Published var searchResults: String = ""
    @Published var searchTerm: String = ""
    @Published private(set) var verses: [VerseViewModel] = []
    @Published var copyrightText = ""
    @Published var isFetching = false
    @Published var error: DataModelError?
    @Published var searchAttempt: Int = 0
    
    private let dataModel: DataModel = DataModel()
    
    func getVerses() async {
        searchAttempt = 0
        do {
            isFetching = true
            let fetchedModel = try await dataModel.fetchVerseModel(searchTerm: searchTerm)
            searchAttempt += 1
            await MainActor.run {
                if let model = fetchedModel {
                    if searchTerm == model.inputstring {
                        self.model = model
                        verses.removeAll()
                        model.verses.forEach {self.appendVerse(verse: $0)}
                        isFetching = false
                    } else {
                        if searchAttempt < 4 {
                            Task {
                                await getVerses()
                            }
                        } else {
                            self.error = DataModelError.apiError
                            isFetching = false
                        }
                    }
                }
            }
        } catch {
            isFetching = false
            if let dataModelError = error as? DataModelError {
                self.error = dataModelError
            } else {
                self.error = DataModelError.unknown
            }
        }
    }
    
    var filterResult: [Verse] {
        guard let model = model else {
            return []
        }

        if searchResults.isEmpty {
            return model.verses
        } else {
            return model.verses.filter{$0.text.contains(searchResults)}
        }
    }
    
    private func appendVerse(verse: Verse){
        let verseViewModel = VerseViewModel(verse: verse)
        self.verses.append(verseViewModel)
    }
    
//    func signOut() throws {
//        verses.removeAll()
//        try AuthenticationManager.shared.signOut()
//    }
//    
//    func resetPassword() async throws {
//        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
//        guard let email = authUser.email else {
//            throw URLError(.fileDoesNotExist)
//        }
//        
//        try await Auth.auth().sendPasswordReset(withEmail: email)
//    }
}
