//
//  WeatherVC.swift
//  rainyshinycloudy
//
//  Created by Vuk Knežević on 2/17/19.
//  Copyright © 2019 Teodora Knežević. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather:CurrentWeather!
    
    var forecasts = [Forecast]()
    
    let locationManager = CLLocationManager()
    var currentLocation:CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        currentWeather = CurrentWeather()
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus(){
        
        //trazi dozvolu za lokaciju.kad dobijes dozvolu skidaj podatke sa lokacijom i update-uj
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            currentLocation = locationManager.location
           // print("LATITUDE " + "\(currentLocation.coordinate.latitude)")
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather.downloadWeatherDetails {
                // ovo u ovim viticastim zagradama je u stvari telo one escaping closure 'fje'
                //kad smo u CLOSURE-u mora se staviti SELF
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell{
            
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        }else{
            return WeatherCell()
        }
    }
    
    
    func updateMainUI(){
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.ikonica)
    }
    
    
    func downloadForecastData(completed: @escaping DownloadComplete){
        
        //skidanje podataka za prognoze narednih 5 dana - za TableView
        Alamofire.request(FORECAST_URL).responseJSON { response in
            
            let result  = response.result
            if let dict = result.value as? Dictionary<String,Any> {
                if let forecast = dict["forecast"] as? Dictionary<String,Any> {
                    if let forecastday = forecast["forecastday"] as? [Dictionary<String,Any>] {
                        
                        for obj in forecastday {
                            let prognoza = Forecast(weatherDict:obj)
                            self.forecasts.append(prognoza)
                            print(obj)
                        }
                        self.forecasts.remove(at: 0)  // ne treba nam prognoza za danas
                        self.tableView.reloadData()
                    }
                }
            }
            completed()
        }
    }


}

