//
//  WeatherCell.swift
//  rainyshinycloudy
//
//  Created by Teodora Knezevic on 3/7/19.
//  Copyright © 2019 Teodora Knežević. All rights reserved.
//

import UIKit

class WeatherCell:UITableViewCell{
    
    @IBOutlet weak var weatherIcon:UIImageView!
    @IBOutlet weak var dayLabel:UILabel!
    @IBOutlet weak var weatherType:UILabel!
    @IBOutlet weak var highTemp:UILabel!
    @IBOutlet weak var lowTmp:UILabel!
    
    func configureCell(forecast:Forecast){
        
        lowTmp.text = "\(forecast.lowTemp)"
        highTemp.text = "\(forecast.highTemp)"
        weatherType.text = "\(forecast.weatherType)"
        dayLabel.text = "\(forecast.date)"
        
        //sad za sliku:
        weatherIcon.image = UIImage(named: forecast.icon)
        
    }
    
}
