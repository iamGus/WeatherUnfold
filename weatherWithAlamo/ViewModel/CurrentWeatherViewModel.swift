//
//  CurrentWeatherViewModel.swift
//  weatherWithAlamo
//
//  Created by Angus Muller on 06/03/2018.
//  Copyright © 2018 Angus Muller. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeatherViewModel {
    let humidity: String
    let rainProbability: String
    let summary: String
    let icon: UIImage
    let temperatureCelsius: String
    let todayDate: String
    let shortSummary: String
    
    init(model: CurrentWeather) {
        let humidityPercentValue = Int(model.humidity * 100)
        self.humidity = "\(humidityPercentValue)%"
        
        let rainPercentValue = Int(model.rainProbability * 100)
        self.rainProbability = "\(rainPercentValue)%"
        
        self.summary = model.summary
        
        let weatherIcon = WeatherIcon(iconString: model.icon)
        self.icon = weatherIcon.image
        
        temperatureCelsius = "\(String(format: "%.0f", model.temperatureCelsius))º"
        
        todayDate = model.currentDate
        
        shortSummary = model.summaryShort
        
    }
}
