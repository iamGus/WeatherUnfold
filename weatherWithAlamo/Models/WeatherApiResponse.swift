//
//  WeatherApiResponse.swift
//  weatherWithAlamo
//
//  Created by Angus Muller on 06/03/2018.
//  Copyright © 2018 Angus Muller. All rights reserved.
//

import Foundation

struct WeatherApiResponse: Decodable {
    
    fileprivate struct ForcastContainer: Decodable {
        let data: [ForcastWeather]
    }
    
    let currentWeather: CurrentWeather
    let forcastWeather: [ForcastWeather]
    
    init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        currentWeather = try keyedContainer.decode(CurrentWeather.self, forKey: .currentWeather)
        forcastWeather = (try keyedContainer.decode(ForcastContainer.self, forKey: .forcastWeather)).data
    }
    
    enum CodingKeys: String, CodingKey {
        case currentWeather = "currently"
        case forcastWeather = "daily"
    }
}
