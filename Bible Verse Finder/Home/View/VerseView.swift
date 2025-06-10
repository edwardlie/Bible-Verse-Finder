//
//  VerseView.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 5/7/25.
//

import SwiftUI

struct VerseView: View {
    var verseViewModel: VerseViewModel
    
    var body: some View {
        HStack {
            Text(verseViewModel.ref)
            VStack(alignment: .leading) {
                Text(verseViewModel.text)
                    .font(.headline)
            }
            .padding()
        }
        .padding()
    }
}
