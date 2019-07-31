//
//  Forecast.swift
//  rainyshinycloudy
//
//  Created by Teodora Knezevic on 3/6/19.
//  Copyright © 2019 Teodora Knežević. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    private var _date:String!
    private var _weatherType:String!
    private var _highTemp:String!
    private var _lowTemp:String!
    
    var icon:String!
    
    var date:String{
        if _date == nil{
            _date = ""
        }
        return _date
    }
    
    var weatherType:String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp:String{
        if _highTemp == nil{
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp:String{
        if _lowTemp == nil{
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    //inicijalizacija ovde ide
    init(weatherDict: Dictionary<String,Any>){
        
        if let date = weatherDict["date"] as? String {   // date = "2019-03-07"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
            let datum = dateFormatter.date(from: date)
            self._date = datum?.dayOfWeek()
        }
        
        if let day = weatherDict["day"] as? Dictionary<String,Any>{
            if let max = day["maxtemp_c"] as? Double{
                self._highTemp = "\(max)"
            }
            if let min = day["mintemp_c"] as? Double{
                self._lowTemp = "\(min)"
            }
            if let condition = day["condition"] as? Dictionary<String,Any>{
                if let text = condition["text"] as? String{
                    self._weatherType = "\(text)"
                }
                //ovo mi treba za ikonicu
                if var icon = condition["icon"] as? String {
                    var karakteri = [Character](icon)
                    karakteri.removeFirst(24)
                    karakteri.removeLast(4)
                    icon = String(karakteri)
                    print("OVO JE ZA IKONICU " + icon)
                    self.icon = icon
                }
            }
        }
        
    }
}


extension Date{
    
    func dayOfWeek() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"    // za pun naziv dana u nedelji
        return dateFormatter.string(from: self)
    }
    
}
