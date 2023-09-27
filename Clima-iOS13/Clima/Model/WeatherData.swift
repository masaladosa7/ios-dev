//
//  WeatherData.swift
//  Clima
//
//  Created by Arya on 15/09/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit

struct WeatherData: Decodable{
    let name : String
    let main: Main
    
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
