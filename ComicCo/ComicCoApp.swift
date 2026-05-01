//
//  ComicCoApp.swift
//  ComicCo
//
//  Created by Student on 4/29/26.
//

import SwiftUI

@main
struct ComicCoApp: App {
    @State private var dataManager = DataManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataManager)
        }
    }
}
