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
                        ComicCollection()
                    }
                }
                
                Tab("Search Comics", systemImage: "magnifyingglass.circle.fill"){
                    Homepage()
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
