//
//  OrderStore.swift
//  CupcakeCorner
//
//  Created by Ihor Sukhachov on 05.12.2025.
//

import Foundation
import Observation

@Observable
class OrderStore {
    private let saveKey = "SavedOrder"

    var order: Order {
        didSet {
            save()
        }
    }

    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
            let decoded = try? JSONDecoder().decode(Order.self, from: data) {
            self.order = decoded
        } else {
            self.order = Order()
        }
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(order) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
}
