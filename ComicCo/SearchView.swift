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
        VStack {
            Text("Search")
            List {
                ForEach(dataManager.issues) { issue in
                    ComicView(comic: issue)
                        .onLongPressGesture(minimumDuration: 1.5){
                            currentComic = issue
                        }
                }
            }
            .sheet(item: $currentComic){ comic in
                ComicDescription(comic: comic)
            }
            .task {
                await dataManager.getIssueData()
            }
            
        }
    }
}
