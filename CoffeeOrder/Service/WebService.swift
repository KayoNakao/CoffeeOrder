//
//  WebService.swift
//  CoffeeOrder
//
//  Created by Kayo on 2025-05-03.
//

import Foundation

enum NetWorkError: Error {
    case badUrl
    case decodingError
    case badRequest
}

class WebService {
    
    private var baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func getOrders() async throws -> [Order] {
        
        guard let url = URL(string: Endpoints.allOrders.path, relativeTo: baseURL) else {
            throw NetWorkError.badUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetWorkError.badRequest
        }
        
        guard let orders = try? JSONDecoder().decode([Order].self, from: data) else {
            throw NetWorkError.decodingError
        }
        
        return orders
    }
}
