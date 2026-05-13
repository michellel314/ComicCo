//
//  ComicDescription.swift
//  ComicCo
//
//  Created by Student on 5/5/26.
//
import SwiftUI
struct ComicDescription: View {
    @Environment(DataManager.self) private var dataManager
    let comic: Comic
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center){
                Text(dataManager.currentData.name ?? "NULL")
                    .font(.title)
                    .padding([.top, .bottom])
                Text("Description")
                    .font(.title2)
                    .underline()
                    .fontWeight(.bold)
                Text(dataManager.currentData.description?.replacingOccurrences(of: "<p>", with: " ").replacingOccurrences(of: "</p>", with: " ").replacingOccurrences(of: "<em>", with: "").replacingOccurrences(of: "</em>", with: "") ?? "404 Not Found")
                    .padding([.bottom])
                Text("Credits")
                    .font(.title2)
                    .underline()
                    .fontWeight(.bold)
                ForEach (dataManager.currentData.person_credits){ person in
                    Text("\(person.name): \(person.role)")
                }
                // Adds selected comic to the collection of comics :D
                let isInCollection = dataManager.collection.contains {$0.id == comic.id}
                Button((!isInCollection) ? "Add to Collection" : "Remove from Collection"){
                    if (!isInCollection){
                        dataManager.addToCollection(comic: comic)
                    } else {
                        dataManager.removeFromCollection(comic: comic)
                    }
                }
                .tint(!isInCollection ? .green : .red)
                .buttonStyle(.borderedProminent)
                .padding([.top, .bottom])
            }
            .frame(maxWidth: .infinity)
            .task {
                await dataManager.getDetailData(detailURL: comic.api_detail_url)
            }
        }
    }
}

