//
//  ComicView.swift
//  ComicCo
//
//  Created by Student on 5/4/26.
//

import SwiftUI

struct ComicView: View {
    let comic: Comic
    var body: some View {
        VStack{
            let imageURL = URL(string: comic.image.medium_url)
            AsyncImage(url: imageURL){ image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            Text(comic.name ?? "")
        }
    }
}



