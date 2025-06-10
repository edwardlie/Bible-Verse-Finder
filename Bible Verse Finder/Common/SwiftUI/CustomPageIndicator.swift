//
//  CustomPageIndicator.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 5/9/25.
//

import SwiftUI

struct CustomPageIndicator: View {
    @Binding var currentIndex: Int
    let pageCount: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<pageCount, id: \.self) { index in
                Circle()
                    .fill(index == currentIndex ? Color.accentColor : Color.gray.opacity(0.4))
                    .frame(width: 10, height: 10)
                    .animation(.easeInOut(duration: 0.2), value: currentIndex)
            }
        }
        .padding(.vertical, 8)
    }
}
