//
//  String+Extension.swift
//  CoffeeOrder
//
//  Created by Kayo on 2025-05-03.
//

import Foundation

extension String {
    
    func isLessThan(_ number: Double) -> Bool {
        
        guard let value = Double(self) else { return false }
        return value < number
    }
    
}
