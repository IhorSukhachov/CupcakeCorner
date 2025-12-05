//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Ihor Sukhachov on 04.12.2025.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation: Bool = false
    
    @State private var errorMessage = ""
    @State private var showingErrorMessage = false
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) {image in
                    image
                        .resizable()
                        .scaledToFit()
                        
                } placeholder: {
                    ProgressView()
                }
                .frame(height:233)
                
                Text("Your total cost is: \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place order") {
                    Task{
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }.navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .scrollBounceBehavior(.basedOnSize)
            .alert("Thank you", isPresented: $showingConfirmation) {
                
            } message: {
                Text(confirmationMessage)
            }
            .alert("Something went wrong", isPresented: $showingErrorMessage) {
                
            } message: {
                Text(errorMessage)
            }
    }
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return}
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("https://reqres.in/api/cupcakes", forHTTPHeaderField: "")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)

            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on the way!"
            showingConfirmation = true
        }
        catch {
            
            if error is URLError {
                errorMessage = "No internet connection"
                showingErrorMessage = true
            }
            print("There was an error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
