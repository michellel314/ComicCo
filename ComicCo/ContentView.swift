//
//  ContentView.swift
//  ComicCo
//
//  Created by Student on 4/29/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(DataManager.self) private var dataManager
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
                            // WHY WON'T YOU WORK
                            ForEach(dataManager.issues) { issue in
                                Text(issue.name ?? "NULL")
                            }
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
