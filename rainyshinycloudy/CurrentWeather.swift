//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by Vuk Knežević on 2/20/19.
//  Copyright © 2019 Teodora Knežević. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather{
    
    var _cityName:String!
    var _date:String!
    var _weatherType:String!
    var _currentTemp:Double!
    
    var ikonica:String!
    
    var cityName:String{
        if _cityName==nil {
                _cityName = ""
        }
        return _cityName
       
    }
    var weatherType:String{
        if _weatherType==nil{
            _weatherType = ""
        }
        return _weatherType
    }
    var currentTemp:Double{
        if _currentTemp==nil{
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    var date:String{
        if _date==nil{
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete){
        
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, Any> {
                
                if let location = dict["location"] as? Dictionary<String,Any>{
                    if let name = location["name"] as? String, var grad = location["tz_id"] as? String{
                       
                        var karakteri = [Character](grad)
                        karakteri.removeFirst(7)
                        grad = String(karakteri)
                        
                        self._cityName = name.capitalized + ", " + grad
                        print("GRAD " + self._cityName)
                    }
                }
                
                if let current = dict["current"] as? Dictionary<String,Any>{
                    
                    if let temp_c = current["temp_c"] as? Double{
                        self._currentTemp = round(temp_c)
                        print(self._currentTemp)
                    }
                    
                    
                    if let condition = current["condition"] as? Dictionary<String,Any>{
                        if let text = condition["text"] as? String{
                            self._weatherType = text
                            print(self._weatherType)
                        }
                        if var icon = condition["icon"] as? String{
                            var karakteri = [Character](icon)
                            karakteri.removeFirst(24)
                            karakteri.removeLast(4)
                            icon = String(karakteri)
                            self.ikonica = icon
                        }
                    }
                }
               
            }
            completed()  // kad zavrsi sa skidanjem onda poziva ovu escaping closure fju 
        }
    }
}
