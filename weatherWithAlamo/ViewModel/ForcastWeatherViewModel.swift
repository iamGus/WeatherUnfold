//
//  ForcastWeatherViewModel.swift
//  weatherWithAlamo
//
//  Created by Angus Muller on 06/03/2018.
//  Copyright © 2018 Angus Muller. All rights reserved.
//

import Foundation
import UIKit

struct ForcastWeatherViewModel {
    let humidity: String
    let rainProbability: String
    let summary: String
    let icon: UIImage
    let temperatureMax: String
    let temperatureMin: String
    let dayOfWeek: String
    let shortSummary: String
    
    init(model: ForcastWeather) {
        let humidityPercentValue = Int(model.humidity * 100)
        self.humidity = "\(humidityPercentValue)%"
        
        let rainPercentValue = Int(model.rainProbability * 100)
        self.rainProbability = "\(rainPercentValue)%"
        
        self.summary = model.summary
        
        let weatherIcon = WeatherIcon(iconString: model.icon)
        self.icon = weatherIcon.image
        
        temperatureMax = "\(String(format: "%.0f", model.temperatureMaxCelsius))º"
        temperatureMin = "\(String(format: "%.0f", model.temperatureMinCelsius))º"
        
        dayOfWeek = model.dayOfTheWeek
        
        shortSummary = model.summaryShort
    }
}
