//
//  QuizStartView.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 5/8/25.
//

import SwiftUI

struct QuizStartView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 40) {
            Text("Choose the correct verse reference")
                .font(.system(size: 64))
                .multilineTextAlignment(.center)
            
            Text("Are you ready to start?")
                .font(.system(size: 24))
            
            Button {
                dismiss()
            } label: {
                Text("Start")
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
    QuizStartView()
}
