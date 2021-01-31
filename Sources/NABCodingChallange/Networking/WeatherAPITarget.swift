//
//  WeatherAPITarget.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/28/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import UIKit
import Moya
import RxSwift

enum WeatherAPITarget {
    case getDailyForcast(q: String, cnt: Int)
}

extension WeatherAPITarget: TargetType {
    var baseURL: URL {
        return ApiConfig.defaultConfig.apiEnvironment.apiURL
    }
    
    var path: String {
        switch self {
        case .getDailyForcast:
            return "forecast/daily"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDailyForcast:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getDailyForcast(q: let query, cnt: let cnt):
            let params = ["q": query, "cnt": cnt, "appid": Constants.ApiConfig.appId, "units": Constants.ApiConfig.defaultUnit] as [String : Any]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
        
    }
    
    var sampleData: Data {
        switch self {
        case .getDailyForcast:
            return Utility.dataFromJSON(fileName: "daily_forecast") ?? Data()
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
