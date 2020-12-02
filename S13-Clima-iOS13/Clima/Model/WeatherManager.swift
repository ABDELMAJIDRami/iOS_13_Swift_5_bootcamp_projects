//
//  WeatherManager.swift
//  Clima
//
//  Created by user183479 on 11/27/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=d5c03d141d4f0a58319e814f272f8144&units=metric"
    // apple will detect if we are using http(insecure) instead of https and throws an error - see GoodNotes
    
    var delegate: WeatherViewController?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // check definition for each class-fct to understand more
        // 1- create a URL
        if let url = URL(string: urlString) {    // check definiton for URL(string:) initializer. it is of type optional URL?. which means it will retun nil if string isempty or not formatted correctly. use if let to safely unwrap it
            
            // 2- create a URLSession
            let session = URLSession(configuration: .default)   // default configuration. I think it is like promise in js. the thing that perform the networking
            
            // 3- give URLSession a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {   // exp: lost connection to internet
                    delegate?.didFailWithError(error: error!)
                    return  // exist the fct
                }
                
                if let safeData = data {
                    // .utf8 was used for string encoding(transform data into string)
                    // but we want to convert data to swift object -> JSON encoding
                    if let weather = parseJson(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            // 4- Start the task
            task.resume()   // desc: Newly-initialized tasks begin in a suspended state, so you need to call this method to start the task.
        }
    }
    
    func parseJson(_ weatherData: Data) -> WeatherModel? {
        // we should inform our compiler how our data is structured - we can do that through a structure we create (exp: WeatherData.swift)
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name // cityName not weather condition name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
