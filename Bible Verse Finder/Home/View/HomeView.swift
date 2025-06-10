//
//  ContentView.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 7/4/23.

import SwiftUI

//struct SearchBar: UIViewRepresentable {
//    typealias UIViewTYpe = UISearchBar
//    @Binding var searchTerm: String
//    
//    func makeUIView(context: Context) -> UISearchBar {
//        let searchBar = UISearchBar(frame: .zero)
//        searchBar.delegate = context.coordinator
//        searchBar.searchBarStyle = .minimal
//        searchBar.placeholder = "Type verse(s)..."
//        return searchBar
//    }
//    
//    func updateUIView(_ uiView: UISearchBar, context: Context) {
//    }
//    
//    func makeCoordinator() -> SearchBarCoordinator {
//        return SearchBarCoordinator(searchTerm: $searchTerm)
//    }
//    
//    class SearchBarCoordinator: NSObject, UISearchBarDelegate {
//        @Binding var searchTerm: String
//        
//        init(searchTerm: Binding<String>) {
//            self._searchTerm = searchTerm
//        }
//        
//        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//            searchTerm = searchBar.text ?? ""
//            UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
//        }
//    }
//}

struct HomeView: View {
    @ObservedObject var viewModel: VerseListViewModel
    @Binding var showSignInView: Bool
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isDetailPresented = false
    @State var selectedVerse: VerseViewModel?
    @State var showPrivacyPolicy = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if !viewModel.verses.isEmpty {
                        List(viewModel.verses) { verse in
                            VerseView(verseViewModel: verse)
                                .onTapGesture {
                                    selectedVerse = verse
                                    isDetailPresented = true
                                }
                        }
                        .listStyle(PlainListStyle())
                    } else {
                       EmptyStateView()
                    }
                    Text(viewModel.model?.copyright ?? "")
                        .font(.caption2)
                }
                
                if viewModel.isFetching {
                    ProgressView()
                }
            }
            .searchable(text: $viewModel.searchTerm, prompt: "Type verse(s) here...")
            .onSubmit(of: .search) {
                Task {
                    await viewModel.getVerses()
                }
            }
            .navigationDestination(isPresented: $isDetailPresented) {
                if let selectedVerse = selectedVerse {
                    VerseDetailView(verseViewModel: selectedVerse)
                        .containerRelativeFrame([.horizontal, .vertical]) { length, axis in
                            return length / 2
                        }
                }
            }
            .errorAlert(error: Binding<Error?>(
                get: { viewModel.error },
                set: { newValue in
                    viewModel.error = newValue as? DataModelError
                }
            ))
            .fullScreenCover(isPresented: $showPrivacyPolicy) {
                PrivacyPolicyView()
            }
            .navigationBarTitle("Bible Verses")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Group {
                        Button {
                            showPrivacyPolicy = true
                        } label: {
                            Text("Privacy Policy")
                        }
//                        Menu("Settings") {
//                            Button("Log Out") {
//                                Task {
//                                    do {
//                                        try viewModel.signOut()
//                                        showSignInView = true
//                                    } catch {
//                                        print(error)
//                                    }
//                                }
//                            }
//
//                            Button("Reset Password") {
//                                Task {
//                                    do {
//                                        try await viewModel.resetPassword()
//                                        showSignInView = true
//                                    } catch {
//                                        print(error)
//                                    }
//                                }
//                            }
//                        }
                        
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView(viewModel: VerseListViewModel(), showSignInView: .constant(false)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
