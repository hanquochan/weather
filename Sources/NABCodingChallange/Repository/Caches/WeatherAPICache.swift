//
//  WeatherAPICache.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/31/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import UIKit

class WeatherAPICache {
    var expireTime: TimeInterval  = 60 * 60 {
        didSet {
            exipreTimer()
        }
    }
    private var caches: [String: Any]
    private var timer: Timer?
    let queue = DispatchQueue(label: "CacheQueue", attributes: .concurrent)
    
    init() {
        caches = [:]
        exipreTimer()
    }
    
    private func exipreTimer() {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: expireTime,
                                     target: self,
                                     selector: #selector(timerHandler),
                                     userInfo: nil,
                                     repeats: true)
    }
    
     @objc private func timerHandler() {
        invalidate()
    }
}

///Mark: - APICachable
extension WeatherAPICache: APICachable {
    subscript(key: String) -> Any? {
        var value: Any? = nil
        queue.sync {
            value = self.caches[key]
        }
        return value
    }
    
    func cache(key: String, value: Any) {
        queue.async(flags: .barrier) {
            self.caches[key] = value
        }
    }
    
    func invalidate() {
         queue.async(flags: .barrier) {
            self.caches.removeAll()
        }
    }
    
    func removeCache(key: String) {
         queue.async(flags: .barrier) {
            self.caches.removeValue(forKey: key)
        }
    }
}
