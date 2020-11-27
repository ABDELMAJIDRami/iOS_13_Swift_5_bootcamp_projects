//
//  WeatherManager.swift
//  Clima
//
//  Created by user183479 on 11/27/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherUrl = "http://api.openweathermap.org/data/2.5/weather?appid=d5c03d141d4f0a58319e814f272f8144&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        print(urlString)
    }
}
