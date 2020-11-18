//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var progressOutlet: UIProgressView!
    var player: AVAudioPlayer!
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0

    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()  // to reset the timer when the button is pressed again
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        progressOutlet.progress = 0.0
        secondsPassed = 0
        titleOutlet.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1,target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressOutlet.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            titleOutlet.text = "Done."
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}
