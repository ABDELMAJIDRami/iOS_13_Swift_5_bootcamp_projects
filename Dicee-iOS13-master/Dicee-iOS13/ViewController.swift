//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // IBoulet: Interface Buideler allows me to reference a UI element
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    var leftDiceNumber = 1;
    var rightDiceNumber = 5;
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Who          What    Value
//        diceImageView1.image = #imageLiteral(resourceName: "DiceSix")
//        diceImageView2.image = #imageLiteral(resourceName: "DiceThree")
//    }
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {  // "sender" is "like" event in Javascript
        var diceArray = [#imageLiteral(resourceName: "DiceOne"), #imageLiteral(resourceName: "DiceTwo"), #imageLiteral(resourceName: "DiceThree"), #imageLiteral(resourceName: "DiceFour"), #imageLiteral(resourceName: "DiceFive"), #imageLiteral(resourceName: "DiceSix")]

        diceImageView1.image = diceArray.randomElement()
        diceImageView2.image = diceArray.randomElement()
        
//        leftDiceNumber += 1
//        rightDiceNumber -= 1
        
//        print("Button got pressed.")
//        diceImageView1.image = #imageLiteral(resourceName: "DiceFour")
//        diceImageView1.alpha = 0.5;
//        diceImageView2.image = #imageLiteral(resourceName: "DiceTwo")
    }
    
}

