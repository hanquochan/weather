//
//  BaseViewController.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/29/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    
    
    /// Subclass need to override this method to bind view model
    func bindViewModel() {
    }
    
    /// Subclass need to override this method to setup view & subviews
    func setupViews() {
    }
}
