//
//  QuizResultsView.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 5/8/25.
//

import SwiftUI

struct QuizResultsView: View {
    @Environment(\.dismiss) var dismiss
    @State var quizResult: QuizResult
    var body: some View {
        VStack(spacing: 40) {
            Text("Bible Verse Finder Quiz")
                .font(.system(size: 64))
                .multilineTextAlignment(.center)
            
            Text("Results")
                .font(.system(size: 36))
            
            VStack(spacing: 10) {
                Text("\(quizResult.correct) out of \(quizResult.total)")
                    .font(.system(size: 32))
                Text(quizResult.grade)
                
                    .font(.system(size: 24))
            }
            
            Text("You completed the quiz!")
                .font(.system(size: 24))
            
            Button {
                dismiss()
            } label: {
                Text("Retake Quiz")
                    .foregroundColor(.white)
                    .frame(width: 340)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color("AppColor"))
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(.bottom, 100)
    }
}

#Preview {
    QuizResultsView(quizResult: QuizResult(correct: 8, total: 10, grade: "80%"))
}
