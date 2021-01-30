//
//  CachePolicyPlugin.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/30/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import UIKit
import Moya

protocol CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy { get }
}

final class CachePolicyPlugin: PluginType {
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let cachePolicyGettable = target as? CachePolicyGettable {
            var mutableRequest = request
            mutableRequest.cachePolicy = cachePolicyGettable.cachePolicy
            return mutableRequest
        }

        return request
    }
}
