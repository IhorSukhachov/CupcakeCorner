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
    
    var name = ""
    var streetAdress = ""
    var city = ""
    var zipCode = ""
    
    var hasValidAddress: Bool {
        return !name.isEmpty && !streetAdress.isEmpty && !city.isEmpty && !zipCode.isEmpty
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
 
