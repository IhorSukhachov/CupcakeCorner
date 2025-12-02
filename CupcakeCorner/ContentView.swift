//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Ihor Sukhachov on 01.12.2025.
//

import SwiftUI

@Observable
class User: Codable {
    var name = "Ihor"
}

struct ContentView: View {
    
    var body: some View {
        Button("Encode Ihor", action: encodeIhor)
        
    }
    
    func encodeIhor() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
}
#Preview {
    ContentView()
}
