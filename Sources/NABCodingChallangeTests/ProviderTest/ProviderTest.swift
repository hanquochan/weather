//
//  ProviderTest.swift
//  NABCodingChallangeTests
//
//  Created by Han Han on 1/31/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import XCTest
import Moya
@testable import NABCodingChallange

class ProviderTest: XCTestCase {
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
    var cache: WeatherAPICache?
    
    override func setUp() {
        errorProvider = WeatherAPIProvider(endpointClosure: serverErrorEndpointClosure, stubClosure: WeatherAPIProvider.immediatelyStub)
        stubbingProvider = WeatherAPIProvider(stubClosure: WeatherAPIProvider.immediatelyStub)
        realProvider = WeatherAPIProvider(stubClosure: WeatherAPIProvider.neverStub, plugins: [NetworkLoggerPlugin()])
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetDailyForcastStubsSuccess() {
        let expectation = self.expectation(description: "Request daily forcast")
        let provider = WeatherProvider(apiProvider: stubbingProvider, cache: nil)
        _ = provider.getDailyForcast(query: "saigon").subscribe(onSuccess: { (response) in
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
        let provider = WeatherProvider(apiProvider: stubbingProvider, cache: nil)
        _ = provider.getDailyForcast(query: "saigon").subscribe(onSuccess: { (response) in
            expectation.fulfill()
        }, onError: { (error) in
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testGetDailyForcastCache() {
        let expectation = self.expectation(description: "Request daily forcast")
        let provider = WeatherProvider(apiProvider: stubbingProvider, cache: cache)
        _ = provider.getDailyForcast(query: "saigon").subscribe(onSuccess: { (response) in
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
}
