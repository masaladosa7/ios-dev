//
//  WeatherManager.swift
//  Clima
//
//  Created by Arya on 15/09/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=669cecf8cf67a215d82fcf8ab059842e&units=metric"
    

    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName:String){
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude : CLLocationDegrees){
        let urlString = "\(weatherUrl)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    
    
    func performRequest(with urlString:String){
        // if let since it creates an optional URL
        if let url = URL(string: urlString){
            
            //ends up creating a url session object which is effectively like our browser
            let session = URLSession(configuration: .default)
            
            //give the session a task
            
            // this is a closure, see carefully , dont get confused
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            })
            
            //start the task
            task.resume()
            
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)

            return weather
                  
                  }
                  
                  catch {
                      delegate?.didFailWithError(error: error)
                    return nil
        }
    }
    
  
    }
    
    

