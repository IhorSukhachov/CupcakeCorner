//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Ihor Sukhachov on 01.12.2025.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ImageView: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) {phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an issue retrieving the image")
            } else {
                ProgressView()
            }
        }
    }
}

struct ContentView: View {
    @State private var results = [Result]()
    @State private var userName: String = ""
    @State private var email: String = ""
    var disabledForm: Bool {
        userName.isEmpty || email.isEmpty
    }
    
    var body: some View {
        
//        List(results, id:\.trackId) {item in
//            VStack(alignment: .leading) {
//                ImageView()
//                Text(item.trackName)
//                    .font(.headline)
//                Text(item.collectionName )
//            }
//        }.task {
//            await loadData()
//        }
        Form {
            Section {
                TextField("Username", text: $userName)
                TextField("Email", text: $email)
            }
            Section {
                Button("Create account") {
                    //
                }
            }.disabled(disabledForm)
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=nickelback&entity=song") else {
            print("Ivalid URL")
            return
        }
        
        do {
             let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse =  try? JSONDecoder().decode(Response.self, from: data) {
                 results = decodedResponse.results
            }
        } catch{
             print("Invalid data ")
        }
        
    }
}

#Preview {
    ContentView()
}
