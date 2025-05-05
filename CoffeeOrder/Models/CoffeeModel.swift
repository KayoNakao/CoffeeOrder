//
//  CoffeeModel.swift
//  CoffeeOrder
//
//  Created by Kayo on 2025-05-03.
//

import Foundation

@MainActor
class CoffeeModel: ObservableObject {
    
    let webService: WebService
    @Published private(set) var orders: [Order] = []
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func populateOrders() async throws {
        orders = try await webService.getOrders()
    }
    
    func placeOrder(_ order: Order) async throws {
        let newOrder = try await webService.placeOrder(order: order)
        orders.append(newOrder)
    }
    
    func deleteOrder(_ orderId: Int) async throws {
        let deleteOrder = try await webService.deleteOrder(orderId)
        orders = orders.filter{ $0.id != deleteOrder.id}
    }
}
