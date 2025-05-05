//
//  ContentView.swift
//  CoffeeOrder
//
//  Created by Kayo on 2025-05-03.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var model: CoffeeModel
    @State private var isPresented = false
    
    private func populateOrders() async {
        do {
            try await model.populateOrders()
        } catch {
            print(error)
        }
    }
    
    private func deleteOrder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            guard let orderId = model.orders[index].id else {
                return
            }
            Task {
                do {
                    try await model.deleteOrder(orderId)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                if model.orders.isEmpty {
                    Text("No orders are found")
                        .accessibilityIdentifier("noOrdersText")
                } else {
                    List {
                        ForEach(model.orders) { order in
                            OrderCellView(order: order)
                        }.onDelete(perform: deleteOrder)
                    }.accessibilityIdentifier("orderList")
                }
            }.task {
                await populateOrders()
            }
            .sheet(isPresented: $isPresented, content: {
                AddCoffeeView()
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add New Order") {
                        isPresented = true
                    }.accessibilityIdentifier("addNewOrderButton")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        var config = Configuration()
        ContentView().environmentObject(CoffeeModel(webService: WebService(baseURL: config.environment.baseURL)))
    }
}
