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
    
    func placeOrder() async {
        let order = Order(name: name, coffeeName: coffeeName, total: Double(price) ?? 0, size: coffeeSize)
        do {
            try await model.placeOrder(order)
            dismiss()
        } catch {
            print(error)
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
                Button("Place Order") {
                    
                    if isValid {
                        Task {
                            await placeOrder()
                        }
                    }
                    
                }.accessibilityIdentifier("placeOrderButton")
                    .centerHorizontally()
            }.navigationTitle("Add Coofee")
        }
    }
}

#Preview {
    AddCoffeeView()
}
