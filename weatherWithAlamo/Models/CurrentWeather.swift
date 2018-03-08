//
//  CurrentWeather.swift
//  weatherWithAlamo
//
//  Created by Angus Muller on 06/03/2018.
//  Copyright © 2018 Angus Muller. All rights reserved.
//

import Foundation

class CurrentWeather: Weather {
    let temperature: Double
    
    var temperatureCelsius: Double {
        let temp = 5 / 9 * (temperature - 32) as Double
        return Double(round(temp))
    }
    
    var currentDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        return "Today, \(currentDate)"
    }
    
    private enum CodingKeys: String, CodingKey {
        case temperature
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temperature = try container.decode(Double.self, forKey: .temperature)
        try super.init(from: decoder)
    }
}
