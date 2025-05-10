//
//  CoffeeOrderE2ETests.swift
//  CoffeeOrderE2ETests
//
//  Created by Kayo on 2025-05-03.
//

import XCTest

final class when_updating_an_existing_order: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        //Go to Add Coffee View
        app.buttons["addNewOrderButton"].tap()
        //Fill out the text feilds
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        
        let exists = nameTextField.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "TextField didn't appear in time")
        
        nameTextField.tap()
        nameTextField.typeText("Mike")
        
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Hot Coffee")
        
        priceTextField.tap()
        priceTextField.typeText("3.50")
        
        //Place order
        let placeOrderButton = app.buttons["placeOrderButton"]
        placeOrderButton.tap()
    }
    
    func test_should_update_order() {
        
        let orderList = app.collectionViews["orderList"]
        orderList.buttons["orderNameText-coffeeNameAndSizeText-coffeePriceText"].tap()
        
        app.buttons["editOrderButton"].tap()
        
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextFiled = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]
        
        let _ = nameTextField.waitForExistence(timeout: 2.0)
        nameTextField.tap(withNumberOfTaps: 2, numberOfTouches: 1)
        nameTextField.typeText("Mike Edit")
        
        let _ = coffeeNameTextField.waitForExistence(timeout: 2)
        coffeeNameTextField.tap(withNumberOfTaps: 2, numberOfTouches: 1)
        coffeeNameTextField.typeText("Hot Coffee Edit")
        
        let _ = priceTextFiled.waitForExistence(timeout: 2)
        priceTextFiled.tap(withNumberOfTaps: 2, numberOfTouches: 1)
        priceTextFiled.typeText("1.50")
        
        placeOrderButton.tap()
        
        XCTAssertEqual("Hot Coffee Edit", app.staticTexts["coffeeNameText"].label)
        
    }
    
    override class func tearDown() {
        Task {
            guard let url = URL(string: "/test/clear-orderes", relativeTo: AppEnvironment.test.baseURL) else { return }
            let (_, _) = try! await URLSession.shared.data(from: url)
        }
    }
}

final class when_deleting_an_order: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        //Go to Add Coffee View
        app.buttons["addNewOrderButton"].tap()
        //Fill out the text feilds
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        
        let exists = nameTextField.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "TextField didn't appear in time")
        
        nameTextField.tap()
        nameTextField.typeText("Mike")
        
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Hot Coffee")
        
        priceTextField.tap()
        priceTextField.typeText("3.50")
        
        //Place order
        let placeOrderButton = app.buttons["placeOrderButton"]
        placeOrderButton.tap()
    }
    
    func test_should_delete_order() {
        
        let collectionViews = XCUIApplication().collectionViews
        let cells = collectionViews.cells
        let element = cells.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        element.swipeLeft()
        collectionViews.buttons["Delete"].tap()
        
        let orderList = app.collectionViews["orderList"]
        XCTAssertEqual(0, orderList.cells.count)
    }
    
    override class func tearDown() {
        Task {
            guard let url = URL(string: "/test/clear-orderes", relativeTo: AppEnvironment.test.baseURL) else { return }
            let (_, _) = try! await URLSession.shared.data(from: url)
        }
    }
    
}

final class when_adding_a_new_coffee_order: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        //Go to Add Coffee View
        app.buttons["addNewOrderButton"].tap()
        //Fill out the text feilds
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        
        let exists = nameTextField.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "TextField didn't appear in time")
        
        nameTextField.tap()
        nameTextField.typeText("Mike")
        
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Hot Coffee")
        
        priceTextField.tap()
        priceTextField.typeText("3.50")
        
        //Place order
        let placeOrderButton = app.buttons["placeOrderButton"]
        placeOrderButton.tap()
    }
    
    func test_should_display_coffee_order_on_list() throws {
        
        XCTAssertEqual("Mike", app.staticTexts["orderNameText"].label)
        XCTAssertEqual("Hot Coffee (Medium)", app.staticTexts["coffeeNameAndSizeText"].label)
        XCTAssertEqual("$3.50", app.staticTexts["coffeePriceText"].label)
    }
    
    override class func tearDown() {
        Task {
            guard let url = URL(string: "/test/clear-orderes", relativeTo: AppEnvironment.test.baseURL) else { return }
            let (_, _) = try! await URLSession.shared.data(from: url)
        }
    }
}


final class when_app_is_launched_with_no_orders: XCTestCase {

    func test_should_show_no_orders_message() {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()

        XCTAssertEqual("No orders are found", app.staticTexts["noOrdersText"].label)
    }

}
