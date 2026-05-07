//
//  ContentView.swift
//  ComicCo
//
//  Created by Student on 4/29/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(DataManager.self) private var dataManager
    @State private var currentComic: Comic?
    var body: some View {
        VStack {
            TabView {
                Tab("My Collection", systemImage: "book.fill"){
                    VStack{
                        Text("collection")
                    }
                }
                
                Tab("Search Comics", systemImage: "magnifyingglass.circle.fill"){
                    VStack {
                        Text("Serch")
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
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environment(DataManager())
}
