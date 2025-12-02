//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Ihor Sukhachov on 01.12.2025.
//

import SwiftUI


struct ContentView: View {
    @State private var counter: Int = 0
    
    var body: some View {
        Button("tap count \(counter)") {
             counter += 1
        }
        .sensoryFeedback(.increase, trigger: counter)
    }
}
#Preview {
    ContentView()
}
