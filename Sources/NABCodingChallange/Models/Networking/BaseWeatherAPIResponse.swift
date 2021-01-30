//
//  BaseWeatherAPIResponse.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/30/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import UIKit

class BaseWeatherAPIResponse: Codable {
    var cod: String?
    var message: String?
    
    private enum CodingKeys: String, CodingKey {
        case cod
        case message
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cod = try? values.decodeIfPresent(String.self, forKey: .cod)
        message = try? values.decodeIfPresent(String.self, forKey: .message)
    }
}

