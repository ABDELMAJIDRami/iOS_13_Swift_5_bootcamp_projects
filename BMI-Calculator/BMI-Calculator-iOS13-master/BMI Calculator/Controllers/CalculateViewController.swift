//
//  CalculateViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    var bmiValue = "0.0"

    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        let height = String(format: "%.2f", sender.value)
        heightLabel.text = "\(height)m"
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        //  weightLabel.text = String(Int(sender.value))
        let weight = String(format: "%.0f", sender.value)
        weightLabel.text = "\(weight)Kg"
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let height = heightSlider.value
        let weight = weightSlider.value
        
        let bmi = weight / pow(height, 2)
        bmiValue = String(format: "%.1f", bmi)
        
        // let secondVC = SecondViewController()
        // secondVC.bmiValue = String(format: "%0.1f", bmi)
        // self.present(secondVC, animated: true, completion: nil)
        
        /* We will use a method that every UIViewController has. we inherited the method in our class.
            withIdentifier: "the name we provide in Main.storyboard"
            sender: who is going to be the initiater of the segue (ourself: CalculateViewController
         */
        self.performSegue(withIdentifier: "goToResult", sender: self)
        // performSegue(withIdentifier: "goToResult", sender: self)    // same as above. not mendatory to add the self keyword.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            // sender.destination: sender.destination will be the ResultViewController initialised when the segue gets trigerred
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiValue = bmiValue
        }
    }
    
} 

