//
//  ApiConfig.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/28/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import UIKit

enum APIEnvironment: String {
    case dev = "dev"
    case prod = "prod"
    
    var apiURL: URL {
        switch self {
        case .dev:
            return URL(string: "https://api.openweathermap.org/data/2.5")!
        case .prod:
            return URL(string: "https://api.openweathermap.org/data/2.5")!
        }
    }
}
struct ApiConfig {
    static var defaultConfig = ApiConfig()
    let apiEnvironment = APIEnvironment(rawValue: Bundle.main.infoDictionary![Constants.ApiConfig.enviroment] as! String)!
}

extension Constants {
    struct ApiConfig {
        static let enviroment = "APIEnvironment"
        static let appId = "60c6fbeb4b93ac653c492ba806fc346d"
        static let defaultUnit = "metric"
        static let defaultCnt = 7
    }
}
