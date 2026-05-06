//
//  Homepage.swift
//  ComicCo
//
//  Created by Student on 5/6/26.
//

import SwiftUI

struct Homepage: View {
    var body: some View {
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
    }
}

#Preview {
    Homepage()
}
