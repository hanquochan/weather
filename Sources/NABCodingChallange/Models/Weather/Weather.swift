//
//  Weather.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/27/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import UIKit

struct Weather: Codable {
    let id: Int?
    let main: String?
    let `description`: String?
    let icon: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case main
        case `description`
        case icon
    }
}
