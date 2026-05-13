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
    @State private var showAlert: Bool = false
    
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
            
            Button("Clear All"){
                showAlert = true
            }
            .alert("CONFIRMATION", isPresented: $showAlert){
                HStack{
                    Button("Yes"){
                        dataManager.clearCollection()
                    }
                    Button("No"){
                        // Nothing happens here
                    }
                }
            } message: {
                Text("Are you sure you want to clear out your precious comic collection?")
            }
            .tint(.red)
        }
        
    }
    
}
