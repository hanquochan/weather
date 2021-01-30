//
//  GetDailyWeatherResponse.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/27/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import UIKit

class GetDailyWeatherResponse: BaseWeatherAPIResponse {
    var city: City?
    var list: [DailyWeather]?
    
    private enum CodingKeys: String, CodingKey {
        case city
        case list
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try? values.decodeIfPresent(City.self, forKey: .city)
        list = try? values.decodeIfPresent([DailyWeather].self, forKey: .list)
        
    }
}
