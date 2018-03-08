//
//  DarkSkyClient.swift
//  weatherWithAlamo
//
//  Created by Angus Muller on 02/03/2018.
//  Copyright © 2018 Angus Muller. All rights reserved.
//

import Foundation
import Alamofire

enum DarkSkyError: Error {
    case requestFailed
    case responseUnsuccessful
    case invalidData
    case jsonConversionFailure
    case invalidUrl
    case jsonParsingFailure
    case unknownError
}

class DarkSkyClient {
    
    typealias CompletionHandler = (Result<[Weather], DarkSkyError>) -> Void

    func getWeather(at coordinates: Coordinate, completionHandler completion: @escaping CompletionHandler) {
        
        let endpoint = DarkSkyEndpoint.forcastRequest(coordinates: coordinates)
        let url = endpoint.url
        //let weatherList = [Weather]()
        
        
        Alamofire.request(url)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { [weak self] response in
            
                switch response.result {
                case .success:
                    
                    /*
                    guard let weatherJson = value as? Dictionary<String, AnyObject> else { return
                        print("in first")
                        completion(Result.failure(DarkSkyError.jsonConversionFailure)) }
                    
                    guard let currentWeatherJson = weatherJson["currently"] as? [String: AnyObject] else {
                        print("in second")
                        return completion(Result.failure(DarkSkyError.jsonParsingFailure))
                    }
                    
                    */
                    
                    guard let data = response.data else {
                         return completion(Result.failure(DarkSkyError.invalidData))
                    }
                    
                    do {
                        let currentWeather = try JSONDecoder().decode(WeatherApiResponse.self, from: data)
                        
                        var array = [Weather]()
                        
                        array.append(currentWeather.currentWeather)
                        for each in currentWeather.forcastWeather {
                            array.append(each)
                        }
                        
                        completion(Result.success(array))
                        
                        
                    } catch let error {
                        print("Parse error: \(error)")
                        completion(Result.failure(DarkSkyError.jsonParsingFailure))
                    }
                   
                    
                    
                    
                case.failure(let error):
                    if let error = error as? AFError {
                        switch error {
                        case .invalidURL( _): return completion(Result.failure(DarkSkyError.invalidUrl))
                        case .responseValidationFailed(let reason): switch reason {
                            case .dataFileNil: return completion(Result.failure(DarkSkyError.invalidData))
                        case .dataFileReadFailed( _): return completion(Result.failure(DarkSkyError.invalidData))
                        case .unacceptableContentType( _, _): return completion(Result.failure(DarkSkyError.invalidData))
                        case .unacceptableStatusCode( _): completion(Result.failure(DarkSkyError.responseUnsuccessful))
                        case .missingContentType( _): return completion(Result.failure(DarkSkyError.unknownError))
                            }
                        case .parameterEncodingFailed( _): return completion(Result.failure(DarkSkyError.jsonConversionFailure))
                        case .multipartEncodingFailed( _): return completion(Result.failure(DarkSkyError.jsonConversionFailure))
                        case .responseSerializationFailed( _): return completion(Result.failure(DarkSkyError.jsonConversionFailure))
                        }
                    } else {
                        return completion(Result.failure(DarkSkyError.unknownError))
                    }
                }
        }
        
        
    }
    
}
