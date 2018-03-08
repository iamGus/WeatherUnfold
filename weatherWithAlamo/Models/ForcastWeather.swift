//
//  ForcastWeather.swift
//  weatherWithAlamo
//
//  Created by Angus Muller on 06/03/2018.
//  Copyright © 2018 Angus Muller. All rights reserved.
//

import Foundation

class ForcastWeather: Weather {
    let temperatureMax: Double
    let temperatureMin: Double
    
    var temperatureMaxCelsius: Double {
        let temp = 5 / 9 * (temperatureMax - 32) as Double
        return Double(round(temp))
    }
    
    var temperatureMinCelsius: Double {
        let temp = 5 / 9 * (temperatureMin - 32) as Double
        return Double(round(temp))
    }
    
    var dayOfTheWeek: String {
        let unixConvertedDate = Date(timeIntervalSince1970: time)
        return unixConvertedDate.dayOfWeek()
    }
    
    private enum CodingKeys: String, CodingKey {
        case temperatureMax
        case temperatureMin
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temperatureMax = try container.decode(Double.self, forKey: .temperatureMax)
        temperatureMin = try container.decode(Double.self, forKey: .temperatureMin)
        try super.init(from: decoder)
    }
}

extension Date {
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
}
