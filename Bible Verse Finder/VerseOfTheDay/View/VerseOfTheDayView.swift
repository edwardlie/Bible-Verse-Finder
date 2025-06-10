//
//  VerseOfTheDayView.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 5/7/25.
//

import SwiftUI

struct VerseOfTheDayView: View {
    @ObservedObject var viewModel: VerseOfTheDayViewModel
    
    var body: some View {
        VStack {
            if !viewModel.verses.isEmpty {                Text(viewModel.verseOfTheDayText)
            } else {
                Text("Loading verse...")
            }
        }
        .task {
            await viewModel.fetchVerseOfTheDay()
        }
    }
}

#Preview {
    VerseOfTheDayView(viewModel: VerseOfTheDayViewModel())
}
