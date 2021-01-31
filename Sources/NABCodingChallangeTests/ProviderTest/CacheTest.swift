//
//  CacheTest.swift
//  NABCodingChallangeTests
//
//  Created by Han Han on 1/31/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import XCTest
@testable import NABCodingChallange

class CacheTest: XCTestCase {
    var cache: WeatherAPICache!
    override func setUp() {
        cache = WeatherAPICache()
    }

    override func tearDown() {
        cache = nil
    }

    func testGetSetCache() {
        let key = "test_key"
        let value = "test_value"
        cache.cache(key: key, value: value)
        XCTAssertEqual(cache[key] as? String, value)
    }

    func testRemoveCache() {
        let key = "test_key"
        let value = "test_value"
        cache.cache(key: key, value: value)
        cache.removeCache(key: key)
        XCTAssertNil(cache[key])
    }
    
    func testRemoveAllCache() {
        let key1 = "test_key1"
        let value1 = "test_value1"
        let key2 = "test_key2"
        let value2 = "test_value2"
        cache.cache(key: key1, value: value1)
        cache.cache(key: key2, value: value2)
        cache.invalidate()
        XCTAssertNil(cache[key1])
        XCTAssertNil(cache[key2])
    }
    
    func testCacheExpire() {
        let cacheShortExpireTime = WeatherAPICache()
        cacheShortExpireTime.expireTime = 1
        let key = "test_key"
        let value = "test_value"
        cacheShortExpireTime.cache(key: key, value: value)
        let exp = expectation(description: "Test after 2 seconds")
        let _ = XCTWaiter.wait(for: [exp], timeout: 2.0)
        XCTAssertNil(cacheShortExpireTime[key])
    }
}
