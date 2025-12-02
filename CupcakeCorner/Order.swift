//
//  Order.swift
//  CupcakeCorner
//
//  Created by Ihor Sukhachov on 02.12.2025.
//

import Foundation

@Observable
class Order {
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
}
 
