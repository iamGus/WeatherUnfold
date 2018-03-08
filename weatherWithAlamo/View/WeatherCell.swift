//
//  WeatherCell.swift
//  weatherWithAlamo
//
//  Created by Angus Muller on 06/03/2018.
//  Copyright © 2018 Angus Muller. All rights reserved.
//

import Foundation
import UIKit

class WeatherCell: FoldingCell {
    
    @IBOutlet weak var forgroundIcon: UIImageView!
    @IBOutlet weak var forgroundDay: UILabel!
    @IBOutlet weak var forgroundWeatherDoing: UILabel!
    @IBOutlet weak var forgroundTempLow: UILabel!
    @IBOutlet weak var forgroundTempHigh: UILabel!
    @IBOutlet weak var forgroundCurrentTemp: UILabel!
    
    @IBOutlet weak var containerHeading: UILabel!
    @IBOutlet weak var containerLowHighView: UIView!
    @IBOutlet weak var containerLowTemp: UILabel!
    @IBOutlet weak var containerHighTemp: UILabel!
    @IBOutlet weak var containerIcon: UIImageView!
    @IBOutlet weak var containerHumidity: UILabel!
    @IBOutlet weak var containerRain: UILabel!
    @IBOutlet weak var containerSummary: UILabel!
    
    
    
    
    override func awakeFromNib() {
        //foregroundView.layer.cornerRadius = 10
        //foregroundView.layer.masksToBounds = true
        cornerSetup()
        super.awakeFromNib()
        // Initialisation code
    }
    
    private func cornerSetup() {
        let path =  UIBezierPath(roundedRect: self.bounds,
                                 byRoundingCorners: [.topLeft],
                                 cornerRadii: CGSize(width: 10.0, height: 10.0))
        let forgroundMaskLayer = CAShapeLayer()
        forgroundMaskLayer.path = path.cgPath
        let containerMaskLayer = CAShapeLayer()
        containerMaskLayer.path = path.cgPath
        foregroundView.layer.mask = forgroundMaskLayer
        containerView.layer.mask = containerMaskLayer
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
    /// Current Weather
    func configure(with viewmodel: CurrentWeatherViewModel) {
        // Forground
        forgroundIcon.image = viewmodel.icon
        forgroundDay.text = "Currently"
        forgroundWeatherDoing.text = viewmodel.shortSummary
        forgroundTempLow.isHidden = true
        forgroundTempHigh.isHidden = true
        forgroundCurrentTemp.text = viewmodel.temperatureCelsius
        forgroundCurrentTemp.isHidden = false
        
        // Container
        containerHeading.text = viewmodel.todayDate
        containerLowHighView.isHidden = true
        containerIcon.image = viewmodel.icon
        containerHumidity.text = viewmodel.humidity
        containerRain.text = viewmodel.rainProbability
        containerSummary.text = viewmodel.summary
    }
    
    /// Forcast Weather
    func configure(with viewmodel: ForcastWeatherViewModel) {
        // Forground
        forgroundIcon.image = viewmodel.icon
        forgroundDay.text = viewmodel.dayOfWeek
        forgroundWeatherDoing.text = viewmodel.shortSummary
        forgroundTempLow.text = viewmodel.temperatureMin
        forgroundTempHigh.text = viewmodel.temperatureMax
        
        // Container
        containerHeading.text = viewmodel.dayOfWeek
        containerLowTemp.text = viewmodel.temperatureMin
        containerHighTemp.text = viewmodel.temperatureMax
        containerIcon.image = viewmodel.icon
        containerHumidity.text = viewmodel.humidity
        containerRain.text = viewmodel.rainProbability
        containerSummary.text = viewmodel.summary
    }
    
}
