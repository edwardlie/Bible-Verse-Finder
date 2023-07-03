//
//  Bible_Verse_FinderApp.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 7/3/23.
//

import SwiftUI

@main
struct Bible_Verse_FinderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
