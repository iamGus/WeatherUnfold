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
    let dataSource = WeatherDataSource()
    var cellHeights: [CGFloat] = []
    
    let kCloseCellHeight: CGFloat = 75
    let kOpenCellHeight: CGFloat = 200
    let kRowsCount = 9
    
    fileprivate struct C {
        struct CellHeight {
            static let close: CGFloat = 95 // equal or greater foregroundView height
            static let open: CGFloat = 179 // equal or greater containerView height
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup Tableview
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableSetup()
        
        client.getWeather(at: Coordinate(latitude: 53.959855, longitude: -1.088708)) { [weak self] result in
        switch result {
            case .success(let weather):
                print("sucess")
                self?.dataSource.update(with: weather)
                self?.tableView.reloadData()
                self?.tableSetup()
            case .failure(let failure):
                print("failure\(failure)")
            }
        }
        
    }
    
    private func tableSetup() {
        cellHeights = Array(repeating: kCloseCellHeight, count: kRowsCount)
        tableView.estimatedRowHeight = kCloseCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        let topColour = UIColor(red: 0/255, green: 109/255, blue: 123/255, alpha: 1.0)
        let bottomColour = UIColor(red: 235/255, green: 179/255, blue: 159/255, alpha: 1.0)
        setTableViewBackgroundGradient(topColour, bottomColour)
        //tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
    }
    
    func setTableViewBackgroundGradient(_ topColor:UIColor, _ bottomColor:UIColor) {
        
        let gradientBackgroundColors = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations = [0.0,1.0]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = gradientLocations as [NSNumber]
        
        gradientLayer.frame = self.tableView.bounds
        let backgroundView = UIView(frame: self.tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        self.tableView.backgroundView = backgroundView
    }
}

extension WeatherController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == kCloseCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    
    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as WeatherCell = cell else {
            return
        }
        
        cell.backgroundColor = .clear
        
        if cellHeights[indexPath.row] == kCloseCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
        
        
    }
    
    
}
