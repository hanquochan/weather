//
//  NABCodingChallangeUITests.swift
//  NABCodingChallangeUITests
//
//  Created by Han Han on 1/27/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import XCTest

class NABCodingChallangeUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testSearchSuccess() {
        let app = XCUIApplication()
        app.launch()
        // get the search bar
        let searchBar = app.searchFields["Search"]
        // get the tabble view
        let table = app.tables
        // Test case keyword < 3 characters, should show empty text
        searchBar.tap()
        searchBar.typeText("sa")
        sleep(2)
        XCTAssert(table.children(matching: .cell).count == 0)
        // Test case keyword >= 3 characters, and get result
        searchBar.buttons["Clear text"].tap()
        searchBar.typeText("saigon")
        sleep(2)
        XCTAssert(table.children(matching: .cell).count == 7)
        // Test cell display correctly
        let cell = table.children(matching: .cell).firstMatch
        XCTAssert(!cell.staticTexts["date_value"].label.isEmpty)
        XCTAssert(!cell.staticTexts["temperature_value"].label.isEmpty)
        XCTAssert(!cell.staticTexts["humidity_value"].label.isEmpty)
        XCTAssert(!cell.staticTexts["pressure_value"].label.isEmpty)
        XCTAssert(!cell.staticTexts["description_value"].label.isEmpty)
        // Test case keyword >= 3 characters, and get no result
        searchBar.buttons["Clear text"].tap()
        searchBar.typeText("saigo")
        sleep(1)
        XCTAssertEqual(table.children(matching: .cell).count, 0)
        XCTAssertEqual(app.staticTexts["lb_error"].label, "city not found")
    }
}
