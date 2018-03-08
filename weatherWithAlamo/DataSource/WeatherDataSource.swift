//
//  WeatherDataSource.swift
//  weatherWithAlamo
//
//  Created by Angus Muller on 01/03/2018.
//  Copyright © 2018 Angus Muller. All rights reserved.
//

import UIKit

class WeatherDataSource: NSObject,  UITableViewDataSource {
 
    private var data = [Weather]()
    
    override init() {
        super.init()
    }
    
    func update(with weather: [Weather]) {
        data = weather
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        let weather = data[indexPath.row]
        
        if let currentWeather = weather as? CurrentWeather {
            let viewModel = CurrentWeatherViewModel(model: currentWeather)
            cell.configure(with: viewModel)
            return cell
        } else if let forcastWeather = weather as? ForcastWeather {
            let viewmodel = ForcastWeatherViewModel(model: forcastWeather)
            cell.configure(with: viewmodel)
            return cell
        }
        
     return cell // if not current or forcast then return empty cell
    }
    
    
    
}

