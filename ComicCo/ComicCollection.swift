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
        ZStack{
            Color(red: 0.14, green: 0.08, blue: 0.00)
                .ignoresSafeArea()
            
            VStack (alignment: .center){
                Text("Collection")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.bold)
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
                                    currentComic = issue
                                }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 30)
                    
                }
                .defaultScrollAnchor(.center, for: .alignment)
                .frame(height: 250)
                
                Rectangle()
                    .fill(Color.brown)
                    .frame(height: 18)
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                
                
                Button("Clear All"){
                    showAlert = true
                }
                .buttonStyle(.borderedProminent)
                .padding([.top, .bottom])
                .tint(.red)
                
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
            }
            
        }
    }
    
}
