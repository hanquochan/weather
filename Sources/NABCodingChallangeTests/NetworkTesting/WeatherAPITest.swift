//
//  NetworkTest.swift
//  NABCodingChallangeTests
//
//  Created by Han Han on 1/29/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import XCTest
@testable import NABCodingChallange
import Moya
import RxSwift

class WeatherAPITest: XCTestCase {
    let serverErrorEndpointClosure = { (target: WeatherAPITarget) -> Endpoint in
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(500, Data())},
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
    var errorProvider: WeatherAPIProvider!
    var stubbingProvider: WeatherAPIProvider!
    var realProvider: WeatherAPIProvider!
    
    override func setUp() {
        errorProvider = WeatherAPIProvider(endpointClosure: serverErrorEndpointClosure, stubClosure: WeatherAPIProvider.immediatelyStub)
        stubbingProvider = WeatherAPIProvider(stubClosure: WeatherAPIProvider.immediatelyStub)
        realProvider = WeatherAPIProvider(stubClosure: WeatherAPIProvider.neverStub, plugins: [NetworkLoggerPlugin()])
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
    
    
    func testGetDailyForcastStubsSuccess() {
        let expectation = self.expectation(description: "Request daily forcast")
        _ = stubbingProvider.getDailyForcast(query: "saigon").subscribe(onSuccess: { (response) in
            XCTAssertNotNil(response)
            XCTAssertEqual(response.cod, "200")
            XCTAssertNotNil(response.list)
            XCTAssertEqual(response.list?.count, 7)
            XCTAssertNotNil(response.city)
            XCTAssertEqual(response.city?.id, 1580578)
            expectation.fulfill()
        }, onError: { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testGetDailyForcastStubsFail() {
        let expectation = self.expectation(description: "Request daily forcast")
        _ = stubbingProvider.getDailyForcast(query: "saigon").subscribe(onSuccess: { (response) in
            expectation.fulfill()
        }, onError: { (error) in
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testGetDailyForcastRealSuccess() {
        let expectation = self.expectation(description: "Request daily forcast")
        _ = realProvider.getDailyForcast(query: "saigon").subscribe(onSuccess: { (response) in
            XCTAssertNotNil(response)
            XCTAssertEqual(response.cod, "200")
            XCTAssertNotNil(response.list)
            XCTAssertEqual(response.list?.count, 7)
            XCTAssertNotNil(response.city)
            expectation.fulfill()
        }, onError: { (error) in
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
}
