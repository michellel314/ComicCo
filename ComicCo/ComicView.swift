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
                    .frame(width: 130, height: 180)
                    .clipped()
            } placeholder: {
                ProgressView()
                    .frame(width: 130, height: 180)
            }
            .cornerRadius(12)
            
            Text(comic.name ?? "Unknown Comic")
                .font(.headline)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: 120)
                .padding(.bottom, 8)
        }
        .frame(width: 140)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 5)
        .padding(.vertical, 8)
    
    }
}



