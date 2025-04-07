//
//  ContentView.swift
//  Bible Verse Finder
//
//  Created by Edward Lie
//
//  Created by Edward Lie on 7/4/23.

import SwiftUI
import CoreData
import Combine

struct SearchBar: UIViewRepresentable {
    typealias UIViewTYpe = UISearchBar
    @Binding var searchTerm: String
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Type verse(s)..."
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
    }
    
    func makeCoordinator() -> SearchBarCoordinator {
        return SearchBarCoordinator(searchTerm: $searchTerm)
    }
    
    class SearchBarCoordinator: NSObject, UISearchBarDelegate {
        @Binding var searchTerm: String
        
        init(searchTerm: Binding<String>) {
            self._searchTerm = searchTerm
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchTerm = searchBar.text ?? ""
            UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
        }
    }
}

struct ContentView: View {
    @ObservedObject var viewModel: VerseListViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchTerm: $viewModel.searchTerm)
                if viewModel.verses.isEmpty {
                    EmptyStateView()
                } else {
                    List(viewModel.verses) { verse in
                        VerseView(data: verse)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            VerseListView()
        }
        .navigationBarTitle("Bible Verses")
    }
}

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
        .padding()
        .foregroundColor(Color(.systemIndigo))
    }
}

struct VerseView: View {
    var data: VerseViewModel
    
    var body: some View {
        HStack {
            Text(data.ref)
            VStack(alignment: .leading) {
                Text(data.text)
                    .font(.headline)
            }
            .padding()
        }
        .padding()
    }
}

struct VerseListView: View {
    var body: some View {
        List {
        }
        .navigationTitle(Text("Bible Verses"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: VerseListViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
