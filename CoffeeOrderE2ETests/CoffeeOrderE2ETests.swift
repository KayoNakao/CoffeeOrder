//
//  CoffeeOrderE2ETests.swift
//  CoffeeOrderE2ETests
//
//  Created by Kayo on 2025-05-03.
//

import XCTest

final class when_app_is_launched_with_no_orders: XCTestCase {

    func test_should_show_no_orders_message() {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()

        XCTAssertEqual("No orders are found", app.staticTexts["noOrdersText"].label)
    }

}
