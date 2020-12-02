//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!    // so an instance of UITextField is auto set for us by xcode
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()   // responsible for getting GSP loaction of the user
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self // .delegate = self should be set before calling locationManager.methods. Otherwise, app will crash
        locationManager.requestWhenInUseAuthorization() // popup menu shown to user to request accessing location permission. A property should be added to info.plist for it to work.
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

// MARK: - UiTextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {  // this extension adopt the UiTextFieldDelegate
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)    // dismiss-hide the keyboard
                    // multipletextFields? -> call .endEditing for each one
        
        print(searchTextField.text!)
    }
    
    
    /* all the following special funcs are being called by the TextField */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        /* fired when user press "return" key */
        
        searchTextField.endEditing(true)
        
        print(searchTextField.text!)    // we choose a specific IBOutlet
        print(textField.text!)  // reference/identifier to textField being delegated sent automatically to the fct - similar to sender param(in searchPressed func) which identify the button being clicked
        // textField.backgroundColor = ...
        
        return true // allow the return process to go through...???
    }
    
    // our controller, by being the delegate, will be notified when textField end editing
    // implement special method that will be fired when .endEditing(true) is fired
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city =  searchTextField.text {    // searchTextField is string? optional and we need to pass string to fetchWeather(). we will use if let to unwrapsearchTextField.text
            weatherManager.fetchWeather(cityName: city)
        }
        
        // textField.text = "55" // ref to the one ended editing
         searchTextField.text = "" // clear field
    }
    
    // every method that have "Should"in its naming is asking for permission
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // here our view controller gets to decide what happens when the user tries to deselect the TextFied(when the user click 'return' or search button). Why prevent user to stop editing and trap them in editing mode? --> textFieldShouldEndEditing useful for doing validation on what user typed
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Typesomething"
        }
        
        return false; // don't allow the user to stop editing - keep the keyboard shown - and textFieldDidEndEditing method will not be triggered
    }
}

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        print(weather.temperature)
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)    // depending on the type of the error u may want to show dialog for the user. But in our case, networking error it might not make sense for the user but benefical during development and testing
    }
}

// MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
//            print(lat)
//            print(lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
