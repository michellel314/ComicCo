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
    @State private var detailComic: Comic?
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack{
            LinearGradient(
                colors: [
                    Color(red: 0.08, green: 0.04, blue: 0.01),
                    Color(red: 0.18, green: 0.10, blue: 0.03)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack (alignment: .center){
                Text("Collection")
                    .font(.custom("ComicRelief-Bold", size: 20))
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                Text("Your saved comic library")
                    .font(.custom("ComicRelief-Bold", size: 20))
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("\(dataManager.collection.count) Comics Saved")
                    .font(.custom("ComicRelief-Bold", size: 15))
                    .fontWeight(.semibold)
                    .foregroundStyle(.white.opacity(0.7))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(20)
                
                
               
                if (dataManager.collection.isEmpty){
                    VStack(spacing: 12) {
                        Text("No comics in your collection yet")
                            .font(.custom("ComicRelief-Bold", size: 20))
                            .foregroundStyle(.gray)
                    }
                    .frame(height: 250)
                } else {
                    ScrollView(.horizontal){
                        HStack(alignment: .center, spacing: 20){
                            ForEach(dataManager.collection){ issue in
                                ComicView(comic: issue)
                                    .frame(width: 150)
                                    .scaleEffect(currentComic?.id == issue.id ? 1.08 : 1.0)
                                    .offset(
                                        y: currentComic?.id == issue.id ? -20 : 0
                                    )
                                    .shadow(
                                        color: .black.opacity(currentComic?.id == issue.id ? 0.3 : 0),
                                        radius: 8
                                    )
                                    .animation(
                                        .spring(response: 0.35, dampingFraction: 0.75),
                                        value: currentComic?.id ?? 0
                                    )
                                    .onTapGesture {
                                        currentComic = issue
                                    }
                                    .onLongPressGesture(minimumDuration: 1.5) {
                                        detailComic = issue
                                    }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 30)
                        
                    }
                    .sheet(item: $detailComic) { comic in
                        ComicDescription(comic: comic)
                    }
                    .defaultScrollAnchor(.center, for: .alignment)
                    .frame(height: 250)
                    
                    // Only show the navigation button if a comic has been selected.
                    // This creates a two-step interaction:
                    // 1. Tap comic to animate it outward
                    // 2. Press button to open the personal rating page
                    if let selectedComic = currentComic {
                        NavigationLink {
                            ComicRatingView(comic: selectedComic)
                        } label: {
                            Text("Open Comic Journal")
                                .padding()
                                .font(.custom("ComicRelief-Bold", size: 20))
                                .frame(maxWidth: 220)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            LinearGradient(
                                colors: [.brown, .black.opacity(0.4)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(height: 22)
                        .padding(.horizontal, 20)
                    
                    
                    Button("Clear All"){
                        showAlert = true
                    }
                    .buttonStyle(.borderedProminent)
                    .padding([.top, .bottom])
                    .tint(.red)
                    .alert("CONFIRMATION", isPresented: $showAlert){
                        Button("Yes") {
                            dataManager.clearCollection()
                        }

                        Button("No", role: .cancel) { }
                    } message: {
                        Text("Are you sure you want to clear out your precious comic collection?")
                    }
                }
                
                
            }
            
        }
    }
    
}
