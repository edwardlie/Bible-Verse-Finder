//
//  ViewModel.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 7/5/23.
//

import Foundation
import Combine

class VerseViewModel: Identifiable, ObservableObject {
  let id: UUID
  let ref: String
  let text: String
  
  init(verse: Verse) {
    self.id = verse.id
    self.ref = verse.ref
    self.text = verse.text
  }
}

class VerseListViewModel: ObservableObject {
    
    @Published var data : Model?
    @Published var searchResults: String = ""
    @Published var searchTerm: String = ""
    @Published public private(set) var verses: [VerseViewModel] = []
    
    private let dataModel: DataModel = DataModel()
    
    var anyCancelable = Set<AnyCancellable>()
    
    func getVerses() {
        guard let url = URL(string: "https://api.lsm.org/recver/txo.php")
        else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                print("data", data)
                print("response", response)
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 &&
                        response.statusCode <= 300 else { throw URLError(.badServerResponse)}
                return data
            }
            .decode(type: Model.self, decoder: JSONDecoder())
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] returnData in
                self?.data = returnData
            }
            .store(in: &anyCancelable)
    }
    
    var filterResult: [Verse] {
        guard let data = data else {
            return []
        }

        if searchResults.isEmpty {
            return data.verses
        } else {
            return data.verses.filter{$0.text.contains(searchResults)}
        }
    }

    init() {
        $searchTerm
            .sink(receiveValue: loadVerses(searchTerm:))
            .store(in: &anyCancelable)
    }
    
    private func loadVerses(searchTerm: String) {
        verses.removeAll()

        dataModel.loadVerses(searchTerm: searchTerm) { verses in
            verses.forEach {self.appendVerse(verse: $0)}
        }
    }
    
    private func appendVerse(verse: Verse){
        let verseViewModel = VerseViewModel(verse: verse)
        print (verse)
        DispatchQueue.main.async {
            self.verses.append(verseViewModel)
        }
    }
}
