//
//  CoffeeOrderApp.swift
//  CoffeeOrder
//
//  Created by Kayo on 2025-05-03.
//

import SwiftUI

@main
struct CoffeeOrderApp: App {
    
    @StateObject private var model: CoffeeModel
    
    init() {
        var config = Configuration()
        let webService = WebService(baseURL: config.environment.baseURL)
        _model = StateObject(wrappedValue: CoffeeModel(webService: webService))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
