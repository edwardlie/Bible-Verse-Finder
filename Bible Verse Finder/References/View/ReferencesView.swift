//
//  ReferencesView.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 5/7/25.
//

import SwiftUI

struct ReferencesView: View {
    @State private var viewModel: ReferencesViewModel
    
    init(viewModel: ReferencesViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if !viewModel.bibleBooks.isEmpty {
                    ScrollView {
                        ScrollView(.horizontal, showsIndicators: false) {
                            Grid(
                                alignment: .leading,
                                horizontalSpacing: 4,
                                verticalSpacing: 8
                            ) {
                                GridRow(alignment: .top) {
                                    Group {
                                        GridColumnNameView("Book", alignment: .leading)
                                        GridColumnNameView("# of Chapters", alignment: .center)
                                        GridColumnNameView("Recommended Abbreviation", alignment: .center)
                                    }
                                }
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                                
                                ForEach(viewModel.bibleBooks, id: \.id) { book in
                                    GridRow(alignment: .top) {
                                        GridRowView(book.bookName, alignment: .leading)
                                        
                                        GridRowView(book.numberOfChapters.intToStringValue, alignment: .center)
                                        
                                        GridRowView(book.recommendedAbbreviation, alignment: .center)
                                    }
                                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                                    
                                    Divider()
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .navigationBarTitle("References")
        }
        .errorAlert(error: Binding<Error?>(
            get: { viewModel.error },
            set: { newValue in
                viewModel.error = newValue as? DataModelError
            }
        ))
        .onAppear {
            viewModel.fetchBibleBooks()
        }
    }
}

extension Int {
    var intToStringValue: String {
        self.description
    }
}

private extension ReferencesView {
    func GridColumnNameView(
        _ title: String,
        alignment: HorizontalAlignment
    ) -> some View {
        GridSpacerView(alignment: alignment) {
            Text(title)
        }
    }
    
    func GridRowView(
        _ value: String,
        alignment: HorizontalAlignment
    ) -> some View {
        GridSpacerView(alignment: alignment) {
            Text(value)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    func GridSpacerView<ContentView: View>(
        alignment: HorizontalAlignment = .leading,
        @ViewBuilder content: () -> ContentView
    ) -> some View {
        HStack {
            if alignment == .trailing {
                Spacer()
            }
            
            content()
            
            if alignment == .leading {
                Spacer()
            }
        }
    }
}

#if DEBUG
private struct ReferencesViewPreview: View {
    private let localFetcher = LocalBibleBooksFetcher()
    
    var body: some View {
        ReferencesView(viewModel: ReferencesViewModel())
    }
}
#Preview {
    ReferencesViewPreview()
}
#endif
