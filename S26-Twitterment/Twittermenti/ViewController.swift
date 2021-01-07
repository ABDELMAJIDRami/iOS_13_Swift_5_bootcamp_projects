//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
//import SwiftyJSON // i was able to parse JSON to string without this Librairy!

class ViewController: UIViewController {
    
    let sentimentClassifier = try! TweetSentimentClassifer(configuration: MLModelConfiguration()) // If you know that your function call will not throw an exception, you can call the throwing function with try! to disable error propagation. Note that this will throw a runtime exception if an error is actually thrown.
    
    // check docs (github readme)
    let swifter = Swifter(consumerKey: "", consumerSecret: "")  // initialize Swifter instance and authenticate ourselves with the Twitter servers using our API key and API Secret
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let prediction = try! sentimentClassifier.prediction(text: "@Apple is a terible company!") // we forced unwarp it bcz we are testing it we don't care so m uchabout catching error
        // print(prediction.label)
                
        // our sentiment analyser was trained on English tweets, so we can only	interpret the sentiment in English
        // argument 'lang' miust preced argument 'count' cz the order in the method follows the official api which will be transaleted to a search query
        // text by default is truncated to 140 chars we can request full-text using TweetModef
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended) { (results, metadata) in
            // results and metadata are to JSON we get back from twitter
            print(results)
            
            var tweets = [TweetSentimentClassiferInput]()
            
            for i in 0..<100 {  // we received 100 tweets indexed from 0 to 99
                if let tweet = results[i]["full_text"].string {  // .string will transform it from JSON to string? type (built-in swift functionality)
                    tweets.append(TweetSentimentClassiferInput(text: tweet))
                }
            }
            
            do {
                let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
                var sentimentScore = 0
                for pred in predictions {
                    let sentiment = pred.label
                    if sentiment == "Pos" {
                        sentimentScore += 1
                    } else if sentiment == "Neg" {
                        sentimentScore -= 1
                    }   // ignore neutral
                }
                print(sentimentScore)
            } catch {
                print("There was an error with making a prediction, \(error)")
            }

        } failure: { (error) in
            print("There was an error with the Twitter API Request, \(error)")
        }

    }

    @IBAction func predictPressed(_ sender: Any) {
    
    
    }
    
}

