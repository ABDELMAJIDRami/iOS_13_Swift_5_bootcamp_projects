//
//  WeatherManager.swift
//  Clima
//
//  Created by user183479 on 11/27/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=d5c03d141d4f0a58319e814f272f8144&units=metric"
    // apple will detect if we are using http(insecure) instead of https and throws an error - see GoodNotes
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        // check definition for each class-fct to understand more
        // 1- create a URL
        if let url = URL(string: urlString) {    // check definiton for URL(string:) initializer. it is of type optional URL?. which means it will retun nil if string isempty or not formatted correctly. use if let to safely unwrap it
            
            // 2- create a URLSession
            let session = URLSession(configuration: .default)   // default configuration. I think it is like promise in js. the thing that perform the networking
            
            // 3- give URLSession a task
            let task = session.dataTask(with: url, completionHandler: handler(data:response:error:)) // will return a task - passing refernece to our callback handler
            
            // 4- Start the task
            task.resume()   // desc: Newly-initialized tasks begin in a suspended state, so you need to call this method to start the task.
        }
    }
    
    func handler(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return  // exist the fct
        }
        
        if let safeData = data {
            // let dataString = String(data: safeData, encoding: String.Encoding.utf8)
            let dataString = String(data: safeData, encoding: .utf8)    // encoding for most of the data that we get from the internet is utf8 - standarised protocol for encoding text in websites
            print(dataString)
        }
    }
}
