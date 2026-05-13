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
                    .frame(height: 220)
                    .frame(maxWidth: .infinity)
                    .clipped()
            } placeholder: {
                ProgressView()
                    .frame(height: 220)
                    .frame(maxWidth: .infinity)
            }
            
            Text(comic.name ?? "Unknown Comic")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom, 8)
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 5)
        .padding(.vertical, 8)
    }
}



