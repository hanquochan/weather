//
//  APICachable.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/31/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import UIKit

protocol APICachable {
    func cache(key: String, value: Any)
    func removeCache(key: String)
    func invalidate()
    subscript(key: String) -> Any? { get }
}
