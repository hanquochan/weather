//
//  ViewModelType.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/28/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import UIKit

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}
