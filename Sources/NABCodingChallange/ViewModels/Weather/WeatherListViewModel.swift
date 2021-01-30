//
//  WeatherListViewModel.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/28/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WeatherListViewModel: ViewModelType {
    var input: WeatherListViewModel.Input
    var output: WeatherListViewModel.Output
    
    fileprivate let provider: WeatherProvider!
    
    struct Input {
        let query: AnyObserver<String>
    }
    
    struct Output {
        let dailyForcast: Observable<[WeatherViewModel]>
        let loading: Observable<Bool>
        let error: Observable<String>
    }
    
    private let disposeBag = DisposeBag()
    
    init(provider: WeatherProvider) {
        self.provider = provider
        let querySubject = PublishSubject<String>()
        self.input = Input(query: querySubject.asObserver())
        let loading = PublishSubject<Bool>()
        let dailyForcast = PublishSubject<[WeatherViewModel]>()
        let error = PublishSubject<String>()
        let query =  querySubject
            .debounce(.milliseconds(300), scheduler: SharingScheduler.make())
            .distinctUntilChanged()
        query
            .filter { $0.count > 2}
            .flatMap({ q -> Observable<Event<GetDailyWeatherResponse>> in
                loading.onNext(true)
                return provider.getDailyForcast(query: q).asObservable().materialize()
            }).do(onNext: { (_) in
                loading.onNext(false)
            }).subscribe(onNext: { event in
                switch event {
                case let .next(result):
                    error.onNext("")
                    dailyForcast.onNext((result.list ?? []).compactMap { WeatherViewModel(dailyWeather: $0)})
                case let .error(e):
                    dailyForcast.onNext([])
                    error.onNext(e.localizedDescription)
                case .completed:
                    break
                }
            }).disposed(by: disposeBag)
        query
            .filter { $0.count <= 2}.subscribe(onNext: { _ in
                dailyForcast.onNext([])
            }).disposed(by: disposeBag)
        self.output = Output(dailyForcast: dailyForcast, loading: loading, error: error)
    }
}
