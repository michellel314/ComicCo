//
//  ComicDescription.swift
//  ComicCo
//
//  Created by Student on 5/5/26.
//
import SwiftUI
struct ComicDescription: View {
    let comicDesc: ComicDetails
    let comic: Comic
    var body: some View {
        ScrollView(.vertical) {
            VStack{
                Text(comicDesc.name ?? "NULL")
                ForEach (comicDesc.person_credits){ person in
                    Text(person.name)
                }
            }
        }
    }
}

