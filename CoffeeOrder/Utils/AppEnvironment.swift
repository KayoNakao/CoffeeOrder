//
//  AppEnvironment.swift
//  CoffeeOrder
//
//  Created by Kayo on 2025-05-03.
//

import Foundation

enum Endpoints {
    
    case allOrders
    case placeOrder
    case deleteOrder(Int)
    
    var path: String {
        switch self {
        case .allOrders:
            return "/test/orders"
        case .placeOrder:
            return "/test/new-order"
        case .deleteOrder(let orderId):
            return "/test/delete/\(orderId)"
        }
    }
}

struct Configuration {
    
    lazy var environment: AppEnvironment = {
        guard let env = ProcessInfo.processInfo.environment["ENV"] else {
            return .dev
        }
        
        if env == "TEST" {
            return .test
        }
        
        return .dev
    }()
}

enum AppEnvironment {
    case dev
    case test
    
    var baseURL: URL {
        switch self {
        case .dev:
            return URL(string: "https://island-bramble.glitch.me")!
        case .test:
            return URL(string: "https://island-bramble.glitch.me")!
        }
    }
}
