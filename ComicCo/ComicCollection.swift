//
//  ComicCollection.swift
//  ComicCo
//
//  Created by Student on 5/8/26.
//

import SwiftUI

struct ComicCollection: View {
    @Environment(DataManager.self) private var dataManager
    @State private var currentComic: Comic?
    
    var body: some View {
        VStack (alignment: .center){
            Text("collection")
            List {
                ForEach(dataManager.collection){ issue in
                    ComicView(comic: issue)
                        .onLongPressGesture(minimumDuration: 1.5){
                            currentComic = issue
                        }
                }
            }
            .sheet(item: $currentComic){ comic in
                ComicDescription(comic: comic)
            }
        }
        
    }
    
}
