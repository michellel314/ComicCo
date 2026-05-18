//
//  SearchView.swift
//  ComicCo
//
//  Created by Student on 5/12/26.
//

import SwiftUI

struct SearchView: View {
    let searchText: String
    @Environment(DataManager.self) private var dataManager
    @State private var currentComic: Comic?

    var body: some View {
        VStack(alignment: .center) {
            Text("Search")
                .foregroundStyle(.red)
            
            List {
                ForEach(dataManager.issues) { issue in
                    ComicView(comic: issue)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .onLongPressGesture(minimumDuration: 1.5){
                            currentComic = issue
                        }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color("topColor"))
            .sheet(item: $currentComic){ comic in
                ComicDescription(comic: comic)
            }
            .task {
                await dataManager.searchIssues(searchText: searchText)
            }
            
        }
    }
}
