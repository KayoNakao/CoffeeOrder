//
//  OrderDetailView.swift
//  CoffeeOrder
//
//  Created by Kayo on 2025-05-05.
//

import SwiftUI

struct OrderDetailView: View {
    
    @EnvironmentObject private var model: CoffeeModel
    
    let orderId: Int
    @State private var isPresented = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        if let order = model.orderById(orderId) {
            VStack(alignment: .leading, spacing: 10) {
                Text(order.coffeeName)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .accessibilityIdentifier("coffeeNameText")
                
                Text(order.size.rawValue)
                    .opacity(0.5)
                Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                
                HStack {
                    Spacer()
                    Button("Delete Order", role: .destructive) {
                        Task {
                            do {
                                try await model.deleteOrder(orderId)
                                dismiss()
                            } catch {
                                print(error)
                            }
                        }
                    }
                    Spacer(minLength: 10)
                    Button("Edit Order") {
                        isPresented = true
                    }.accessibilityIdentifier("editOrderButton")
                    Spacer()
                }.sheet(isPresented: $isPresented) {
                    AddCoffeeView(order: order)
                }
                
                Spacer()
            }.padding()
        }
    }
}

//#Preview {
//    var config = Configuration()
//    OrderDetailView(orderId: 1).environmentObject(CoffeeModel(webService: WebService(baseURL: config.environment.baseURL)))
//}
