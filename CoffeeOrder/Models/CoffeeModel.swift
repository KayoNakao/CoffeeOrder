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
    
    func orderById(_ id: Int) -> Order? {
        let order = orders.first(where: { $0.id == id })
        return order
    }
    
    func populateOrders() async throws {
        orders = try await webService.getOrders()
    }
    
    func placeOrder(_ order: Order) async throws {
        let newOrder = try await webService.placeOrder(order: order)
        orders.append(newOrder)
        print("new Order", newOrder.id)
    }
    
    func deleteOrder(_ orderId: Int) async throws {
        let deleteOrder = try await webService.deleteOrder(orderId)
        orders = orders.filter{ $0.id != deleteOrder.id}
    }
    
    func updateOrder(_ order: Order) async throws {
        let updatedOrder = try await webService.updateOrder(order)
        guard let index = orders.firstIndex(where: { $0.id == updatedOrder.id }) else {
            throw CoffeeOrderError.invalidOrderId
        }
        orders[index] = updatedOrder
    }
}
