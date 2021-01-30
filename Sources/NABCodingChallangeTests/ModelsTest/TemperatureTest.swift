//
//  TemperatureTest.swift
//  NABCodingChallangeTests
//
//  Created by Han Han on 1/27/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import XCTest
@testable import NABCodingChallange

class TemperatureTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testMappingModel() {
        let jsonData = Utility.dataFromJSON(fileName: "temperature", bundle: Bundle(for: type(of: self)))
        XCTAssertNotNil(jsonData)
        let temperature = try? JSONDecoder().decode(Temperature.self, from: jsonData!)
        XCTAssertNotNil(temperature)
        XCTAssertEqual(temperature?.day, 32.74)
        XCTAssertEqual(temperature?.min, 23.26)
        XCTAssertEqual(temperature?.max, 34.33)
        XCTAssertEqual(temperature?.night, 25.37)
        XCTAssertEqual(temperature?.evening, 28.47)
        XCTAssertEqual(temperature?.morning, 23.26)
    }
}
