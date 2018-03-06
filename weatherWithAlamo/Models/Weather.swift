//
//  Weather.swift
//  weatherWithAlamo
//
//  Created by Angus Muller on 02/03/2018.
//  Copyright © 2018 Angus Muller. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    let time: Double
    
    var currentDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        return "Today, \(currentDate)"
    }
    
    var dayOfTheWeek: String {
        
        let unixConvertedDate = Date(timeIntervalSince1970: time)
        return unixConvertedDate.dayOfWeek()
    }
    
    let temperature: Double?
    var temperatureCelsius: Double? {
        guard let temperature = temperature else {
            return nil
        }
        let temp = 5 / 9 * (temperature - 32) as Double
        return Double(round(temp))
    }
    let humidity: Double
    let rainProbability: Double
    let summary: String
    let icon: String
    let temperatureMax: Double?
    let temperatureMin: Double?
    
    private enum CodingKeys: String, CodingKey {
        case time
        case temperature
        case humidity
        case rainProbability = "precipProbability"
        case summary
        case icon
        case temperatureMax
        case temperatureMin
    }
    
    /*
    private enum CurrentlyKeys: String, CodingKey {
        case currently
    }
    */
    /*
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CurrentlyKeys.self)
        let weatherValues = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .currently)
        temperature = try weatherValues.decode(Double.self, forKey: .temperature)
        humidity = try weatherValues.decode(Double.self, forKey: .humidity)
        rainProbability = try weatherValues.decode(Int.self, forKey: .rainProbability)
        summary = try weatherValues.decode(String.self, forKey: .summary)
        icon = try weatherValues.decode(String.self, forKey: .icon)
        temperatureMax = try weatherValues.decodeIfPresent(Double.self, forKey: .temperatureMax)
        temperatureMin = try weatherValues.decodeIfPresent(Double.self, forKey: .temperatureMin)
    }
    */
   
    
    
}

extension Date {
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
}
