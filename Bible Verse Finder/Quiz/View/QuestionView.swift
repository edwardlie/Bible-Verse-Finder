//
//  QuestionView.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 5/8/25.
//

import SwiftUI

struct Question: Identifiable {
    let id = UUID()
    let title: String
    let answer: String
    let options: [String]
    var selection: String?
}

struct QuestionView: View {
    @Binding var question: Question
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(question.title)
                .padding(.bottom)
            
            ForEach(question.options, id:\.self) { option in
                HStack {
                    Button {
                        question.selection = option
                    } label: {
                        if question.selection == option {
                            Circle()
                                .shadow(radius: 3)
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color("AppColor"))
                        } else {
                            Circle()
                                .stroke()
                                .shadow(radius: 3)
                                .frame(width: 24, height: 24)
                        }
                    }
                    
                    Text(option)
                }
            }
        }
        .foregroundColor(Color(uiColor: .secondaryLabel))
        .padding(.horizontal, 20)
        .frame(width: 340, height: 550, alignment: .leading)
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(20)
        .shadow(color: Color(uiColor: .label).opacity(0.2), radius: 15)
    }
}

#Preview {
    QuestionView(question: .constant(Question(title: "When was the iPhone first released?",
                                              answer: "A", options: ["A", "B", "C", "D"])))
}
