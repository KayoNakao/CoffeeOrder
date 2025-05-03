//
//  NumberFormatter+Extensions.swift
//  CoffeeOrder
//
//  Created by Kayo on 2025-05-03.
//

import Foundation

extension NumberFormatter {
    
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
