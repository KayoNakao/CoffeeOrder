//
//  AddCoffeeView.swift
//  CoffeeOrder
//
//  Created by Kayo on 2025-05-03.
//

import SwiftUI

struct AddCoffeeError {
    var name = ""
    var coffeeName = ""
    var price = ""
}

struct AddCoffeeView: View {
    
    var order: Order?
    @State private var name = ""
    @State private var coffeeName = ""
    @State private var price = ""
    @State private var coffeeSize: CoffeeSize = .medium
    @State private var errors = AddCoffeeError()
    @EnvironmentObject private var model: CoffeeModel
    @Environment(\.dismiss) private var dismiss
    
    var isValid: Bool {
        errors = AddCoffeeError()
        if name.isEmpty {
            errors.name = "Please enter your name"
        }
        if coffeeName.isEmpty {
            errors.coffeeName = "Please enter the coffee name"
        }
        if price.isEmpty {
            errors.price = "Please enter the price"
        } else if price.isLessThan(1) {
            errors.price = "Price must be greater than 1"
        }
        return errors.name.isEmpty && errors.price.isEmpty && errors.coffeeName.isEmpty
    }
    
    func saveOrUpdateOrder() async {
        
        guard let order else {
            await placeOrder()
            return
        }
        await updateOrder(order)
    }
    
    private func updateOrder(_ order: Order) async {
        var editOrder = order
        editOrder.id = order.id
        editOrder.name = name
        editOrder.total = Double(price) ?? 0
        editOrder.coffeeName = coffeeName
        editOrder.size = coffeeSize
        
        do {
            try await model.updateOrder(editOrder)
            dismiss()
        } catch {
            print(error)
        }
    }
    
    private func placeOrder() async {
        let order = Order(name: name, coffeeName: coffeeName, total: Double(price) ?? 0, size: coffeeSize)
        do {
            try await model.placeOrder(order)
            
            dismiss()
        } catch {
            print(error)
        }
    }
    
    func populateExistingOrder() {
        if let order = order {
            name = order.name
            coffeeName = order.coffeeName
            price = String(order.total)
            coffeeSize = order.size
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .accessibilityIdentifier("name")
                Text(errors.name).visible(!errors.name.isEmpty)
                    .font(.system(size: 12))
                    .foregroundStyle(.red)
                
                TextField("Coffee Name", text: $coffeeName)
                    .accessibilityIdentifier("coffeeName")
                Text(errors.coffeeName).visible(!errors.coffeeName.isEmpty)
                    .font(.system(size: 12))
                    .foregroundStyle(.red)
                
                TextField("Price", text: $price)
                    .keyboardType(.numbersAndPunctuation)
                    .accessibilityIdentifier("price")
                Text(errors.price).visible(!errors.price.isEmpty)
                    .font(.system(size: 12))
                    .foregroundStyle(.red)
                
                Picker("Select Size", selection: $coffeeSize) {
                    ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
                        Text(size.rawValue).tag(size)
                    }
                }.pickerStyle(.segmented)
                Button(order != nil ? "Update Order" : "Place Order") {
                    
                    if isValid {
                        Task {
                            await saveOrUpdateOrder()
                        }
                    }
                    
                }.accessibilityIdentifier("placeOrderButton")
                    .centerHorizontally()
            }.navigationTitle(order != nil ? "Update Order" : "Add Coffee")
                .onAppear {
                    populateExistingOrder()
                }
        }
    }
}

#Preview {
    AddCoffeeView()
}
