//
//  QuizView.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 5/8/25.
//

import SwiftUI

struct QuizView: View {
    @StateObject var quizViewModel = QuizViewModel()
    @State var selection = 0
    @State var showStart = true
    @State var showResults = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text(quizViewModel.copyright)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.caption2)
                    Spacer()
                    Button {
                        Task { await quizViewModel.getVerses() }
                    } label: {
                        Text("Refresh")
                    }
                }
                .padding(.horizontal, 16)
                
                VStack(spacing: 20) {
                    Stepper("Question Count: \(quizViewModel.numberOfQuestions)", value: $quizViewModel.numberOfQuestions, in: 1...20)
                }
                .padding()
                
                CustomPageIndicator(currentIndex: $selection, pageCount: quizViewModel.numberOfQuestions)
                
                TabView(selection: $selection) {
                    ForEach(quizViewModel.questions.indices, id: \.self) { index in
                        ScrollView {
                            VStack {
                                QuestionView(question: $quizViewModel.questions[index])
                                    .padding(.top, 24)
                                
                                if let lastQuestion = quizViewModel.questions.last,
                                   lastQuestion.id == quizViewModel.questions[index].id {
                                    Button {quizViewModel
                                        .gradeQuiz()
                                        showResults = true
                                        quizViewModel.resetQuiz()
                                        selection = 0
                                    } label: {
                                        Text("Submit")
                                            .foregroundColor(.white)
                                            .frame(width: 340)
                                            .padding()
                                            .background(
                                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                                    .fill(Color("AppColor"))
                                            )
                                    }
                                    .buttonStyle(.plain)
                                    .disabled(!quizViewModel.canSubmitQuiz())
                                }
                                
                                Spacer()
                            }
                            .tag(index)
                        }
                    }
                    .padding(.vertical, 40)
                    
                    if quizViewModel.verseListViewModel.isFetching {
                        ProgressView()
                    }
                }
                .frame(height: geometry.size.height)
                .scrollClipDisabled()
            }
        }
        .background(Color(uiColor: .systemGray6))
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .fullScreenCover(isPresented: $showStart) {
            QuizStartView()
        }
        .fullScreenCover(isPresented: $showResults) {
            QuizResultsView(quizResult: quizViewModel.quizResult)
        }
        .errorAlert(error: Binding<Error?>(
            get: { quizViewModel.verseListViewModel.error },
            set: { newValue in
                quizViewModel.verseListViewModel.error = newValue as? DataModelError
            }
        ))
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.label
            UIPageControl.appearance().pageIndicatorTintColor = UIColor.secondaryLabel
        }
    }
}

#Preview {
    QuizView(showStart: false)
}
