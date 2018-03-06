//
//  WeatherController.swift
//  weatherWithAlamo
//
//  Created by Angus Muller on 01/03/2018.
//  Copyright © 2018 Angus Muller. All rights reserved.
//

import UIKit
import Alamofire

class WeatherController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
   
    let client = DarkSkyClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = DarkSkyEndpoint.forcastRequest(coordinates: Coordinate(latitude: 53.959855, longitude: -1.088708))
        print(url.url)
        
        client.getWeather(at: Coordinate(latitude: 53.959855, longitude: -1.088708)) { [weak self] result in
            switch result {
        
            case .success(let success):
                print("sucess")
            case .failure(let failure):
                print("failure\(failure)")
            }
        }
        
    }

   

}

