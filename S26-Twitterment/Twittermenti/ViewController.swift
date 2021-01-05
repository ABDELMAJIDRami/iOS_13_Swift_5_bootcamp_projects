//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS

class ViewController: UIViewController {
    // check docs (github readme)
    let swifter = Swifter(consumerKey: "", consumerSecret: "")  // initialize Swifter instance and authenticate ourselves with the Twitter servers using our API key and API Secret
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        swifter.searchTweet(using: "@Apple") { (results, metadata) in
            // results and metadata are to JSON we get back from twitter
            print(results)
        } failure: { (error) in
            print("There was an error with the Twitter API Request, \(error)")
        }

    }

    @IBAction func predictPressed(_ sender: Any) {
    
    
    }
    
}

