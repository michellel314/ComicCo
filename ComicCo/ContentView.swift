//
//  ContentView.swift
//  ComicCo
//
//  Created by Student on 4/29/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TabView {
                Tab("My Collection", systemImage: "book.fill"){
                    
                }
                
                Tab("Search Comics", systemImage: "magnifyingglass.circle.fill"){
                    
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
