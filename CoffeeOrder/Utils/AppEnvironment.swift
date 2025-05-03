//
//  AppEnvironment.swift
//  CoffeeOrder
//
//  Created by Kayo on 2025-05-03.
//

import Foundation

enum Endpoints {
    
    case allOrders
    
    var path: String {
        switch self {
        case .allOrders:
            return "/orders"
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
