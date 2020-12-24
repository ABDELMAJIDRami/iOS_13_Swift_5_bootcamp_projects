//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by user183479 on 12/22/20.
//  Copyright © 2020 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    private var number: Double?
    
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    mutating func calculate(symbol: String) -> Double? {
        if let n = number {
            switch symbol {
            case "+/-":
                return n * -1
            case "AC":
                return 0
            case "%":
                return n * 0.01
            case "=":
                return performTwoNumCalculation(n2: n)
            default:
                intermediateCalculation = (n1: n, calcMethod: symbol)
            }
        }
        return nil
    }
    
    func performTwoNumCalculation(n2: Double) -> Double? {
        if let n1 = intermediateCalculation?.n1,
           let operation = intermediateCalculation?.calcMethod {
            switch operation {
            case "+":
                return n1 + n2
            
            case "-":
                return n1 - n2
            case "×":   // copy it from storyboard. this is a symbol not letter x
            return n1 * n2
            case "÷":
                return n1 / n2
            default:    // throw an error cz this case should not happen
                fatalError("The operation passed in does not match any of the cases.")
            }
        }
        return nil
    }
}
