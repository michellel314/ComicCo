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
                Text("SHEET")
                Text(dataManager.currentData.name ?? "NULL")
                ForEach (dataManager.currentData.person_credits){ person in
                    Text(person.name)
                }
            }
            .frame(maxWidth: .infinity)
            .task {
                await dataManager.getDetailData(detailURL: comic.api_detail_url)
            }
        }
    }
}

