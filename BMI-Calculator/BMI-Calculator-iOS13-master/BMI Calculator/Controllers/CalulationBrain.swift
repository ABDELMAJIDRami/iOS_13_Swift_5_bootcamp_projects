//
//  CalulationBrain.swift
//  BMI Calculator
//
//  Created by user183479 on 11/25/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation

struct CalculatorBrain{
    var bmi: Float = 0.0
    // var bmi: Float? // we can use optional(it is like assigning bmi to nil) but in this case we should use bmi!. But is it safe to do that? no cz the app will crash if we called getBMIValue func before calculateBMI. what is the solution for handling optional then? --> see next episode
    
    func getBMIValue() -> String {
        let bmiTo1DecimalPlace = String(format: "%.1f", bmi)
        return bmiTo1DecimalPlace
    }
    
    mutating func calculateBMI(height: Float, weight: Float) {
        bmi = weight / (height * height)
    }
    
}
