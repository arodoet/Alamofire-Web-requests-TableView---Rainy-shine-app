//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by Vuk Knežević on 2/20/19.
//  Copyright © 2019 Teodora Knežević. All rights reserved.
//

import Foundation

//let BASE_URL = "https://api.openweathermap.org/data/2.5/weather?"
//let LATITUDE = "lat="
//let LONGITUDE = "&lon="
//let UNITS = "&units=metric"  // da bude u celzijusu
//let APP_ID = "&appid="
//let API_KEY = "d1e9e76d28d013a0443240fb7985ac4b"
//let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)44.78\(LONGITUDE)20.46\(UNITS)\(APP_ID)\(API_KEY)"  //nasumicni brojevi cisto da proverimo url


typealias DownloadComplete = ()->()

let CURRENT_WEATHER_URL = "https://api.apixu.com/v1/current.json?key=f2c1e5b6237c477184b140201190603&q=" + String(Location.sharedInstance.latitude) + "," + String(Location.sharedInstance.longitude)


let FORECAST_URL = "https://api.apixu.com/v1/forecast.json?key=f2c1e5b6237c477184b140201190603&q=" + String(Location.sharedInstance.latitude) + "," + String(Location.sharedInstance.longitude) + "&days=6"

//https://api.openweathermap.org/data/2.5/weather?lat=44.56&lon=22.42&units=metric&appid=d1e9e76d28d013a0443240fb7985ac4b

