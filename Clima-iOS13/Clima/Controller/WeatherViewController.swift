//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager() //getting hold of the current gps location
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        //to ask the user to access their location(shows pop up on screen)
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        
        weatherManager.delegate = self
        
        // basically searchtext field is telling the viewcontroller if someone interacted with it. self refers to the current viewController
        searchTextField.delegate = self
    }


    
    @IBAction func locationPressed(_ sender: UIButton) {
        
        locationManager.requestLocation()
    }
    
    

}





// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    // when search button gets pressed
        @IBAction func searchPressed(_ sender: UIButton) {
            searchTextField.endEditing(true)
        }
        
        
        // we dont call these methods anywhere in the code as they get triggered automatically by the textField class
        
        //whenever user presses return this is triggered
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            searchTextField.endEditing(true)
            return true // tells if it should process the return
            
        }
        
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            if searchTextField.text != ""{
                return true
            }
            else{
                searchTextField.placeholder = "not quite right"
                return false
            }
            
        }
        
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            if let city = searchTextField.text{
                weatherManager.fetchWeather(cityName: city)
                
            }
            
            searchTextField.text = ""
        }
        
}

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.async {
            
            //updating the ui
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
        
        
    }
    
    func didFailWithError(error: Error) {
        print(error)   // do this depending on the error
    }
}

// API key : 669cecf8cf67a215d82fcf8ab059842e


// MARK: - CLLocationManagrDelegate

extension WeatherViewController : CLLocationManagerDelegate{
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ){
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
