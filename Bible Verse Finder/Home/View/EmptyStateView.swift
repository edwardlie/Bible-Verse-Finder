//
//  EmptyStateView.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 5/7/25.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "magnifyingglass")
                .font(.system(size: 85))
                .padding(.bottom)
            Text("Start searching for verses...")
                .font(.title)
            Spacer()
        }
        .foregroundColor(Color(.systemIndigo))
    }
}
