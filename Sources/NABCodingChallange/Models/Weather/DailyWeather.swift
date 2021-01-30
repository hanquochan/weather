//
//  DailyWeather.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/27/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import UIKit

class DailyWeather: Codable {
    var clouds: Double?
    var weather: [Weather]?
    var date: Double?
    var pressure: Int?
    var humidity: Int?
    var temperature: Temperature?
    
    private enum CodingKeys: String, CodingKey {
        case clouds
        case weather
        case date = "dt"
        case pressure
        case humidity
        case temperature = "temp"
    }
}
