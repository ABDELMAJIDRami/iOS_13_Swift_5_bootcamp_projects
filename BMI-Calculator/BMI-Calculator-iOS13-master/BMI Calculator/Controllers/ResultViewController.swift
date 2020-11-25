//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by user183479 on 11/22/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var bmiValue: String?   // optional cz at first i don't what's the value is gonna be - i will pass the value after i calculate it inside CalculateViewController. Bcz the Segue is responsible for initiating the ResultViewController how can we set the bmiValue property? Look at the navigation section commented out below: we need to do some preparation by overriding the prepare func and run some code just before the segue initiate.use segue.desitination to hold a reference to the new ResultViewController instance.
    var advice: String?
    var color: UIColor?
    
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet var colorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bmiLabel.text = bmiValue    // notice that we are not force unwrapping bmiValue bcz bmiLabel.text accepts an optional cz we can have a Label with no text
        adviceLabel.text = advice
        // regarding our view we always had access to it and it is already linked to our code - see screenshot
        view.backgroundColor = color
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil) // dismiss the viewComtroller that was presented modally
                                // completion: (() -> void)? ;; nil meets do nothing after dismiss completion
        // dismiss(animated: true, completion: nil) // both are the same - xcode is smart enough to know that we are calling a class method. we can either put self. or not. i prefer putting it to make things clearer and easy to undersatnd what's going on.
    }
    

}
