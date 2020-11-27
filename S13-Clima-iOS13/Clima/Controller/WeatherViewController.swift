//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!    // so an instance of UITextField is auto set for us by xcode
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchTextField.delegate = self
    }

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

