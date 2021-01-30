//
//  WeatherViewModel.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/29/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import UIKit

class WeatherViewModel {
    var dailyWeather: DailyWeather!
    
    init(dailyWeather: DailyWeather) {
        self.dailyWeather = dailyWeather
    }
    
    var date: String {
        if let dateTime = dailyWeather.date {
            let date = Date(timeIntervalSince1970: dateTime)
            let df = DateFormatter()
            df.dateStyle = .full
            return df.string(from: date)
        }
        return ""
    }

    var avarageTemperature: String {
        if let temperature = dailyWeather.temperature,
            let max = temperature.max,
            let min = temperature.min {
            return String(format: "%.02f°C", (max + min)/2)
        }
        return ""
    }
    
    var pressure: String {
        if let pressure = dailyWeather.pressure {
            return "\(pressure)"
        }
        return ""
    }
    
    var humidity: String {
        if let humidity = dailyWeather.humidity {
                   return "\(humidity)%"
               }
        return ""
    }
    
    var weatherDescription: String {
        return dailyWeather.weather?.first?.description ?? ""
    }
}
