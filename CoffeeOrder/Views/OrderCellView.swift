//
//  OrderCellView.swift
//  CoffeeOrder
//
//  Created by Kayo on 2025-05-03.
//

import SwiftUI

struct OrderCellView: View {
    
    let order: Order
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.name).accessibilityIdentifier("orderNameText").bold()
                Text("\(order.coffeeName) (\(order.size.rawValue))")
                    .accessibilityIdentifier("coffeeNameAndSizeText")
                    .opacity(0.5)
            }
            Spacer()
            Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                .accessibilityIdentifier("coffeePriceText")
        }
    }
}

#Preview {
    OrderCellView(order: Order(id: 0, name: "Mike", coffeeName: "Coffee", total: 2.50, size: .medium))
}
