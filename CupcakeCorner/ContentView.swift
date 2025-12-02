//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Ihor Sukhachov on 01.12.2025.
//

import SwiftUI


struct ContentView: View {
    @State private var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cupcake", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self ) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests", isOn: $order.specialRequestsEnabled.animation())
                    
                    if order.specialRequestsEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery Details") {
                        AddressView(order: order)
                    }
                }
            }.navigationTitle("Cupcake Corner")
        }
    }
}



#Preview {
    ContentView()
}
