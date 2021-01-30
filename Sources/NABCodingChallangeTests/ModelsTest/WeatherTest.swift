//
//  WeatherTest.swift
//  NABCodingChallangeTests
//
//  Created by Han Han on 1/27/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import XCTest
@testable import NABCodingChallange

class WeatherTest: XCTestCase {

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
        let jsonData = Utility.dataFromJSON(fileName: "weather", bundle: Bundle(for: type(of: self)))
        XCTAssertNotNil(jsonData)
        let weather = try? JSONDecoder().decode(Weather.self, from: jsonData!)
        XCTAssertNotNil(weather)
        XCTAssertEqual(weather?.id, 802)
        XCTAssertEqual(weather?.main, "Clouds")
        XCTAssertEqual(weather?.icon, "03d")
        XCTAssertEqual(weather?.description, "scattered clouds")

    }
}
