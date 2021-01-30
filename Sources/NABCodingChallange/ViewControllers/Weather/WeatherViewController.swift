//
//  WeatherViewController.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/29/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Moya

class WeatherViewController: BaseViewController {
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var viewModel: WeatherListViewModel!
    let searchController = UISearchController(searchResultsController: nil)
    let searchText = PublishSubject<String>()
    //MARK: - Override
    override func setupViews() {
        super.setupViews()
        self.title = Constants.LocalizedString.weatherForecast
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        tbView.tableHeaderView = searchController.searchBar
        tbView.tableFooterView = UIView()
        self.title = Constants.LocalizedString.cancel
    }
    
    override func bindViewModel() {
        let apiProvider = WeatherAPIProvider(plugins: [NetworkLoggerPlugin(), CachePolicyPlugin()])
        let cache = WeatherAPICache()
        let provider = WeatherProvider(apiProvider: apiProvider, cache: cache)
        viewModel = WeatherListViewModel(provider: provider)
        searchText.asObservable().bind(to: viewModel.input.query).disposed(by: disposeBag)
        viewModel.output.dailyForcast.catchErrorJustReturn([]).bind(to: tbView.rx.items(cellIdentifier: WeatherTableViewCell.cellReuseIdentifier, cellType: WeatherTableViewCell.self)) { index, model, cell in
            let cell = cell as WeatherTableViewCell
            cell.bindTo(viewModel: model)
        }.disposed(by: disposeBag)
        viewModel.output.error.bind(to: errorLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.error.subscribe(onNext: { [weak self] e in
            guard let strongSelf = self else { return }
            if !e.isEmpty {
                strongSelf.errorLabel.isHidden = false
            } else {
                strongSelf.errorLabel.isHidden = true
            }
        }).disposed(by: disposeBag)
        viewModel.output.loading.bind(to: loadingView.rx.isAnimating).disposed(by: disposeBag)
    }
}

extension WeatherViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        searchText.onNext(searchController.searchBar.text ?? "")
    }
    
}
