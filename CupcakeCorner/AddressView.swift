//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Ihor Sukhachov on 02.12.2025.
//

import SwiftUI
 
struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street", text: $order.streetAdress)
                TextField("City", text: $order.city)
                TextField("Postal code", text: $order.zipCode)
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline )
    }
}

#Preview {
    AddressView(order: Order())
}
 
