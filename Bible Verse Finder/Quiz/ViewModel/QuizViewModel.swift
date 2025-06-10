//
//  QuizViewModel.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 5/8/25.
//

import SwiftUI

@MainActor
class QuizViewModel: ObservableObject {
    private(set) var isFetching: Bool = true
    @Published var verses: [VerseViewModel] = []
    @Published var verseListViewModel = VerseListViewModel()
    @Published var copyright: String = ""
    @Published var numberOfQuestions = 3
    @Published var quizResult = QuizResult(correct: 0, total: 0, grade: "100%")
    @Published var questions = [Question]()
    @Published var bibleBooks: [BibleBook] = []
    @Published var showAlert = false
    @Published var error: DataModelError?
    
    func canSubmitQuiz() -> Bool {
        questions.filter({$0.selection == nil}).isEmpty
    }
    
    func gradeQuiz() {
        var correct: CGFloat = 0
        for question in questions {
            if question.answer == question.selection {
                correct += 1
            }
        }
        self.quizResult = QuizResult(correct: Int(correct), total: questions.count, grade: "\(round(correct/CGFloat(questions.count)) * 100)%")
    }
    
    func resetQuiz() {
        self.questions = questions.map({Question(title: $0.title, answer: $0.answer, options: $0.options, selection: nil)})
    }
    
    func getVerses() async {
        var newQuestions: [Question] = []
        var searchTerm = ""
        for _ in 1...self.numberOfQuestions {
            searchTerm += "\(await getRandomVerseRef()),"
        }
        searchTerm = String(searchTerm.dropLast())
        verseListViewModel.searchTerm = searchTerm
        await verseListViewModel.getVerses()
        
        for verse in verseListViewModel.verses {
            let options = [
                verse.ref,
                await getRandomVerseRef(),
                await getRandomVerseRef(),
                await getRandomVerseRef()
            ].shuffled()
            newQuestions.append(
                Question(title: verse.text, answer: verse.ref, options: options)
            )
        }
            
        await MainActor.run {
            self.verses = verseListViewModel.verses
            self.copyright = verseListViewModel.model?.copyright ?? ""
            self.questions = newQuestions
        }
    }
    
    init() {
        Task {
            await getVerses()
        }
    }
    
    func getRandomVerseRef() async -> String {
        do {
            if bibleBooks.isEmpty {
                bibleBooks = try await AppData.shared.fetchBibleBooks()
                isFetching = false
                return getRandomVerse()
            } else {
                return getRandomVerse()
            }
        } catch {
            if let dataModelError = error as? DataModelError {
                self.error = dataModelError
            } else {
                self.error = DataModelError.unknown
            }
            return ""
        }
    }
    
    func getRandomVerse() -> String {
        // pick random bible book by choosing a book with index from 0 to 65
        let randomBookIndex = Int.random(in: 0..<bibleBooks.count)
        // pick number from 1 to last chapter in book
        let numberOfChaptersInBook = bibleBooks[randomBookIndex].numberOfChapters
        if numberOfChaptersInBook == 1 {
            // get number from 1 to the last verse
            let randomVerseNumber = Int.random(in: 1...bibleBooks[randomBookIndex].numberOfVerses[0])
            // just return the book name and a number from 1 to the last verse
            return "\(bibleBooks[randomBookIndex].bookName) \(randomVerseNumber)"
        } else {
            let randomChapterNumber = Int.random(in: 1...numberOfChaptersInBook)
            // for that chapter, look at the number of verses in that chapter
            let randomVerseNumber = Int.random(in: 1...bibleBooks[randomBookIndex].numberOfVerses[randomChapterNumber - 1])
            return "\(bibleBooks[randomBookIndex].bookName) \(randomChapterNumber):\(randomVerseNumber)"
        }
    }
}

struct QuizResult {
    let correct: Int
    let total: Int
    let grade: String
}
