//
//  VerseDetailView.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 5/7/25.
//

import SwiftUI

struct VerseDetailView: View {
    var verseViewModel: VerseViewModel
    var body: some View {
        VStack {
            Text(verseViewModel.ref)
                .font(.headline)
            Text(verseViewModel.text)
        }
        .multilineTextAlignment(.center)
        ShareLink(item: verseViewModel.shareText) {
            Label("Share", systemImage: "square.and.arrow.up")
        }
    }
}

#Preview {
    VerseDetailView(verseViewModel: VerseViewModel(verse: Verse(ref: "John 1:1", text: "In the beginning was the Word, and the Word was God, and the Word was with God.", urlpfx: "")))
}
