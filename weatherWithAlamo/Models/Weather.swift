//
//  Weather2.swift
//  weatherWithAlamo
//
//  Created by Angus Muller on 06/03/2018.
//  Copyright © 2018 Angus Muller. All rights reserved.
//

import Foundation

// Superclass that Current and Forcast subclass from

class Weather: Decodable {
    let time: Double
    let humidity: Double
    let rainProbability: Double
    let summary: String
    let icon: String
    
    var summaryShort: String {
        let oldString = icon
        let newString = oldString.replacingOccurrences(of: "-", with: " ")
        return newString.capitalized
    }

    
    private enum CodingKeys: String, CodingKey {
        case time
        case humidity
        case rainProbability = "precipProbability"
        case summary
        case icon
    }
    
}




