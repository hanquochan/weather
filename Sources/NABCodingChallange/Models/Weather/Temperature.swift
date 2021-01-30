//
//  Temperature.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/27/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import UIKit

struct Temperature: Codable {
    let max: Double?
    let min: Double?
    let day: Double?
    let night: Double?
    let evening: Double?
    let morning: Double?
    
    private enum CodingKeys: String, CodingKey {
        case max
        case min
        case day
        case night
        case evening = "eve"
        case morning = "morn"
    }
}
