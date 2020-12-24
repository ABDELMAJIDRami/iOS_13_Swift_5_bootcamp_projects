//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var isFinishedTypingNumber = true   // that should be displayed on screen
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert display label text to a Double.")
            }
            return number
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    private var calculator = CalculatorLogic()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        //What should happen when a non-number button is pressed
        isFinishedTypingNumber = true
        calculator.setNumber(displayValue)
        if let calcMehtod = sender.currentTitle {
           
            if let result = calculator.calculate(symbol: calcMehtod) {
            displayValue = result
            }
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        //What should happen when a number is entered into the keypad
        if let numValue = sender.currentTitle {
            // inspect .currentTitle. It is a getter(read-only) computed property. It can also be nil bcz it is optional and we don't want nil values in our calculator
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                
                if numValue == "." {
                    /* These checks implemented by Angela doesn't cover all the case. exp: add 2. then try adding . => will fail. Failing is good cz we know that there is something wrong and we know where. */
                    
                    let isInt = floor(displayValue) == displayValue
                    // exp: if currentDisplayValue = 8.1 -> floor will give 8. 8.1 != 8 => so we have a decimal value that have a dot inside
                    // in this case we should prevent adding dots
                    if !isInt {
                        return  // stop func execution
                    }
                }
                
                displayLabel.text = displayLabel.text! + numValue
            }
        }
    }

}

