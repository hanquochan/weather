//
//  WeatherAPIProvider.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/28/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

final class WeatherAPIProvider: MoyaProvider<WeatherAPITarget> {
    /// Get daily forcast
    ///
    /// - Returns: daily forcast response
    func getDailyForcast(query: String, cnt: Int = Constants.ApiConfig.defaultCnt) -> Single<GetDailyWeatherResponse> {
        return rx.request(WeatherAPITarget.getDailyForcast(q: query, cnt: cnt)).catchAPIError().map(GetDailyWeatherResponse.self).flatMap({ Single.just($0)});
    }
}
