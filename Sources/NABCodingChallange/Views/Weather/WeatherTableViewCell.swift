//
//  WeatherTableViewCell.swift
//  NABCodingChallange
//
//  Created by Han Han on 1/29/21.
//  Copyright © 2021 HanKorea. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    static let cellReuseIdentifier = "WeatherTableViewCell"
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    func bindTo(viewModel: WeatherViewModel) {
        self.dateLabel.text = viewModel.date
        self.descriptionLabel.text = viewModel.weatherDescription
        self.temperatureLabel.text = viewModel.avarageTemperature
        self.humidityLabel.text = viewModel.humidity
        self.pressureLabel.text = viewModel.pressure
    }
}
