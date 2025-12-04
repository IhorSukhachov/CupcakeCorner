//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Ihor Sukhachov on 04.12.2025.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
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
    }
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {return}
    }
}

#Preview {
    CheckoutView(order: Order())
}
