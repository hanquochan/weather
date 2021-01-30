//
//  ObserverType.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/30/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import RxSwift
import RxCocoa
import Moya

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    func catchAPIError() -> Single<Element> {
        return flatMap { (response) -> Single<Element> in
            if 200 ... 299 ~= response.statusCode {
                return Single.just(response)
            }
            do {
                let error = try JSONDecoder().decode(WeatherAPIError.self, from: response.data)
                throw error
            } catch {
                throw error
            }
        }
    }
}

