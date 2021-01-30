//
//  WeatherListViewModelTest.swift
//  NABCodingChallangeTests
//
//  Created by Han Han on 1/29/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import RxCocoa

@testable import NABCodingChallange

class WeatherListViewModelTest: XCTestCase {
    var stubbingProvider: WeatherProvider!
    var viewModel: WeatherListViewModel!
    var testScheduler: TestScheduler!
    var disposeBag = DisposeBag()
    override func setUp() {
        let apiProvider = WeatherAPIProvider(stubClosure: WeatherAPIProvider.immediatelyStub)
        stubbingProvider = WeatherProvider(apiProvider: apiProvider, cache: nil)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testWeatherListViewModelOutput() {
        let jsonData = Utility.dataFromJSON(fileName: "daily_forecast")
        XCTAssertNotNil(jsonData)
        let response = try? JSONDecoder().decode(GetDailyWeatherResponse.self, from: jsonData!)
        XCTAssertNotNil(response)
        testScheduler = TestScheduler(initialClock: 0)
        SharingScheduler.mock(scheduler: testScheduler) {
            viewModel = WeatherListViewModel(provider: stubbingProvider)
            let dailyObserver = testScheduler.createObserver([WeatherViewModel].self)
            let loadingObserver = testScheduler.createObserver(Bool.self)
            testScheduler.createColdObservable([.next(10 , ""), .next(100 , "sa"), .next(400 , "sai")]).bind(to: viewModel.input.query).disposed(by: disposeBag)
            viewModel.output.dailyForcast.subscribe(dailyObserver).disposed(by: disposeBag)
            viewModel.output.loading.subscribe(loadingObserver).disposed(by: disposeBag)
            testScheduler.start()
             XCTAssertEqual(dailyObserver.events[0].value.element?.count, 0)
            XCTAssertEqual(dailyObserver.events[1].value.element?.count, 0)
            XCTAssertEqual(dailyObserver.events[2].value.element?.count, 7)
            XCTAssertEqual(loadingObserver.events[0].value.element, true)
            XCTAssertEqual(loadingObserver.events[1].value.element, false)
        }
    }
}
