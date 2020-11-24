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
    
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bmiLabel.text = bmiValue
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil) // dismiss the viewComtroller that was presented modally
                                // completion: (() -> void)? ;; nil meets do nothing after dismiss completion
        // dismiss(animated: true, completion: nil) // both are the same - xcode is smart enough to know that we are calling a class method. we can either put self. or not. i prefer putting it to make things clearer and easy to undersatnd what's going on.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
