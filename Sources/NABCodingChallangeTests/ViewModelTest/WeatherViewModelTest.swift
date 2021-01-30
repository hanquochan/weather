//
//  WeatherViewModelTest.swift
//  NABCodingChallangeTests
//
//  Created by Han Han on 1/29/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import XCTest
@testable import NABCodingChallange

class WeatherViewModelTest: XCTestCase {
    var viewModel: WeatherViewModel!
    var dailyWeather: DailyWeather!
    override func setUp() {
        let jsonData = Utility.dataFromJSON(fileName: "daily_weather", bundle: Bundle(for: type(of: self)))
        dailyWeather = try? JSONDecoder().decode(DailyWeather.self, from: jsonData!)
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
    
    func testWeatherViewModelOutputDefault() {
        let viewModel = WeatherViewModel(dailyWeather: DailyWeather())
        XCTAssertTrue(viewModel.date.isEmpty)
        XCTAssertTrue(viewModel.avarageTemperature.isEmpty)
        XCTAssertTrue(viewModel.pressure.isEmpty)
        XCTAssertTrue(viewModel.humidity.isEmpty)
        XCTAssertTrue(viewModel.weatherDescription.isEmpty)
    }
    
    func testWeatherViewModelOutput() {
        let viewModel = WeatherViewModel(dailyWeather: dailyWeather!)
        XCTAssertFalse(viewModel.date.isEmpty)
        XCTAssertEqual(viewModel.avarageTemperature, "28.80°C")
        XCTAssertEqual(viewModel.pressure, "1011")
        XCTAssertEqual(viewModel.humidity, "42%")
        XCTAssertEqual(viewModel.weatherDescription, "scattered clouds")
    }
}
