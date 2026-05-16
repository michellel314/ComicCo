//
//  ComicRatingView.swift
//  ComicCo
//
//  Created by Michelle Lee on 5/15/26.
//

import SwiftUI

struct ComicRatingView: View {
    @Environment(DataManager.self) private var dataManager
    let comic : Comic
    var body: some View {
        VStack(spacing: 25){
            Text(comic.name ?? "Unknown Comic")
                .font(.title2)
                .bold()
            
            Text("Rating: \(dataManager.ratings[comic.id] ?? 5.0, specifier: "%.1f")")
            
            // Slider is bound directly to the selected comic's rating.
            // Moving the slider updates the rating dictionary in real time,
            // which also automatically saves due to didSet.
            Slider(
                value: Binding(
                    get: {
                        dataManager.ratings[comic.id] ?? 5.0
                    },
                    
                    set: { newValue in
                        dataManager.ratings[comic.id] = newValue
                    }
                ),
                in: 0...10,
                step: 0.5
            )
            .padding(.horizontal)
            
            
            // Removes the saved rating for this comic,
            // resetting it back to the default slider value.
            Button("Reset Rating"){
                dataManager.ratings.removeValue(forKey: comic.id)
            }
            .tint(.red)
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
    }
}
