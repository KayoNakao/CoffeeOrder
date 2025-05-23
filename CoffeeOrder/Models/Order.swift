//
//  Order.swift
//  CoffeeOrder
//
//  Created by Kayo on 2025-05-03.
//

import Foundation

enum CoffeeOrderError: Error {
    case invalidOrderId
}

enum CoffeeSize: String, Codable, CaseIterable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
}

struct Order: Identifiable, Codable, Hashable {
    
    var id: Int?
    var name: String
    var coffeeName: String
    var total: Double
    var size: CoffeeSize
}
