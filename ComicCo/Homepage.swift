//
//  Homepage.swift
//  ComicCo
//
//  Created by Student on 5/6/26.
//

import SwiftUI

struct Homepage: View {
    @State private var searchText = ""
    @State private var rotate = false
    @Environment(DataManager.self) private var dataManager
    
    let colors: [Color] = [
            .red, .orange, .yellow,
            .green, .blue, .purple, .pink
        ]
    
    var body: some View {
        NavigationStack{
            ZStack{
                ZStack {
                    ForEach(0..<12){ index in
                        RoundedRectangle(cornerRadius: 6)
                            .fill(colors[index % colors.count])
                            .frame(width: 35, height: 35)
                        
                            // makes them form a circle
                            .offset(y: -220)
                        
                            // rotates each one evenly
                            .rotationEffect(
                                .degrees(Double(index) * 30)
                            )
                    }
                }
                .rotationEffect(
                    .degrees(rotate ? 360 : 0)
                )
                .animation(
                    .linear(duration: 20)
                    .repeatForever(autoreverses: false),
                    value: rotate
                )
                .opacity(0.3)
                VStack(alignment: .center){
                    HStack {
                        Text("C")
                            .foregroundStyle(.red)
                            .fontWeight(.bold)
                        Text("O")
                            .foregroundStyle(.orange)
                            .fontWeight(.bold)
                        Text("M")
                            .foregroundStyle(.green)
                            .fontWeight(.bold)
                        Text("I")
                            .foregroundStyle(.blue)
                            .fontWeight(.bold)
                        Text("C")
                            .foregroundStyle(.purple)
                            .fontWeight(.bold)
                        
                        Text("O")
                            .foregroundStyle(.pink)
                            .fontWeight(.bold)
                        Text(".")
                    }
                    TextField("Search for comics", text: $searchText)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal, 30)
                    
                    NavigationLink {
                        SearchView(searchText: searchText)
                    } label: {
                        Text("Search")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.black)
                            .cornerRadius(12)
                            .padding(.horizontal, 30)
                    }
                    .disabled(searchText.isEmpty)
                    
                }
                .background(Color.gray.opacity(0.4))
                .cornerRadius(12)
                .padding(.horizontal, 30)
            }
            .background(Color.black)
            .onAppear {
                rotate = true
            }
    
            
        }
    }
}

#Preview {
    Homepage()
        .environment(DataManager())
}
