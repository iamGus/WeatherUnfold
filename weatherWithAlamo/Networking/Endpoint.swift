
//
//  Endpoint.swift
//  weatherWithAlamo
//
//  Created by Angus Muller on 02/03/2018.
//  Copyright © 2018 Angus Muller. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
}

extension Endpoint {
    var urlCompoenents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        
        return components
    }
    
    var url: URL {
        let url = urlCompoenents.url!
        return url
    }
}

enum DarkSkyEndpoint {
    case forcastRequest(coordinates: Coordinate)
}

extension DarkSkyEndpoint: Endpoint {
    var base: String {
        return Constants.BASEENDPOINT
    }
    
    var path: String {
        switch self {
        case .forcastRequest(let coordinate): return "/\(Constants.FORECAST)/\(Constants.APIKEY)/\(coordinate.description)"
        }
    }
}
