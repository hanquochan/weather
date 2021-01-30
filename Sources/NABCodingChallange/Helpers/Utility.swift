//
//  Utility.swift
//  MoneyForward
//
//  Created by Macintosh HD on 10/1/18.
//  Copyright © 2018 Korea. All rights reserved.
//


import UIKit

class Utility {
    static func dataFromJSON(fileName: String, bundle: Bundle? = nil) -> Data? {
        let resourceBundle = bundle ?? Bundle.main
        guard !fileName.isEmpty, let url = resourceBundle.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return nil
        }
        return data
    }
}
