//
//  WeatherAPIError.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/30/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import UIKit

class WeatherAPIError: BaseWeatherAPIResponse, LocalizedError {
    var errorDescription: String? {
        return self.message
    }
}
