//
//  RootView.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 4/9/25.
//

import SwiftUI

struct RootView: View {
    @State private var showSignInView: Bool = false
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        TabView {
            ZStack {
                HomeView(viewModel: VerseListViewModel(), showSignInView: $showSignInView)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            .tabItem {
                Label("Verses", systemImage: "list.dash")
            }
            
            ReferencesView(viewModel: ReferencesViewModel())
                .tabItem {
                    Label("References", systemImage: "book")
                }
            
            QuizView()
                .tabItem {
                    Label("Quiz", systemImage: "text.bubble")
                }
            
//            VerseOfTheDayView(viewModel: VerseOfTheDayViewModel())
//                .tabItem {
//                    Label("Verse of the Day", systemImage: "note")
//                }
        }
    }
}

#Preview {
    RootView()
}
