//
//  Coordinate.swift
//  weatherWithAlamo
//
//  Created by Angus Muller on 02/03/2018.
//  Copyright © 2018 Angus Muller. All rights reserved.
//

import Foundation

struct Coordinate {
    let latitude: Double
    let longitude: Double
}

extension Coordinate: CustomStringConvertible {
    var description: String {
        return "\(latitude),\(longitude)"
    }
}
