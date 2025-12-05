//
//  Order.swift
//  CupcakeCorner
//
//  Created by Ihor Sukhachov on 02.12.2025.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestsEnabled = "specialRequestsEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAdress = "streetAddress"
        case _zipCode = "zipCode"
    }
    
    static let types = ["Vanilla", "Strawberry", "Red Velvet", "Chocolate", "Carrot Cake "]
    var type = 0
    var quantity = 3
    var specialRequestsEnabled: Bool = false {
        didSet {
            if specialRequestsEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting: Bool = false
    var addSprinkles: Bool = false
    
    private let addressKey = "SavedAddress"

        var name = "" {
            didSet { saveAddress() }
        }

        var streetAdress = "" {
            didSet { saveAddress() }
        }

        var city = "" {
            didSet { saveAddress() }
        }

        var zipCode = "" {
            didSet { saveAddress() }
        }

        init() {
            if let data = UserDefaults.standard.data(forKey: addressKey),
               let decoded = try? JSONDecoder().decode(Address.self, from: data) {
                self.name = decoded.name
                self.streetAdress = decoded.streetAdress
                self.city = decoded.city
                self.zipCode = decoded.zipCode
            }
        }

        private struct Address: Codable {
            let name: String
            let streetAdress: String
            let city: String
            let zipCode: String
        }

        private func saveAddress() {
            let address = Address(
                name: name,
                streetAdress: streetAdress,
                city: city,
                zipCode: zipCode
            )

            if let encoded = try? JSONEncoder().encode(address) {
                UserDefaults.standard.set(encoded, forKey: addressKey)
            }
        }
    
    
    
    var hasValidAddress: Bool {
        return !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !streetAdress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !zipCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var cost: Decimal {
        //one cake = 2$
        var cost = Decimal(quantity) * 2
        //complication cost
        cost += Decimal(type) / 2
        //extra frosting 1$
        if extraFrosting {
            cost += Decimal(quantity)
        }
        // sprinkles option 0.5$
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        return cost
    }
}
 
