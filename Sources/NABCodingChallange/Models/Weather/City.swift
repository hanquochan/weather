//
//  City.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/27/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import UIKit

struct City: Codable {
    var id: Int?
    var name: String?
    var country: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case country
    }
}
