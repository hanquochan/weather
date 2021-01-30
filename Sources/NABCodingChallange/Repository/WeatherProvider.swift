//
//  WeatherProvider.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/31/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

class WeatherProvider {
    let apiProvider: WeatherAPIProvider!
    let cache: WeatherAPICache?
    
    init(apiProvider: WeatherAPIProvider, cache: WeatherAPICache?) {
        self.apiProvider = apiProvider
        self.cache = cache
    }
    
     func getDailyForcast(query: String, cnt: Int = Constants.ApiConfig.defaultCnt) -> Single<GetDailyWeatherResponse> {
        let target = WeatherAPITarget.getDailyForcast(q: query, cnt: cnt)
        let key = "\(target.path)\\\(query)\\\(cnt)"
        if let value = cache?[key] as? GetDailyWeatherResponse {
            return Single.just(value)
        } else {
            return apiProvider.getDailyForcast(query: query, cnt: cnt).do(onSuccess: {[weak self] (response) in
                guard let strongSelf = self else { return }
                strongSelf.cache?.cache(key: key, value: response)
            })
        }
       
    }
}
