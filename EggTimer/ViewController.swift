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
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var eggDoneSound: AVAudioPlayer?
    
    // Intialization
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var timer: Timer!
    var totalTime = 0
    var secondsPassed = 0
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        totalTime = Int(eggTimes[sender.currentTitle!]!)
        secondsPassed = 0
        progressBar.progress = 0.0
        titleLabel.text = sender.currentTitle!
        
        if (timer != nil) {
            timer.invalidate()
        }
        
        print("Egg time for \(sender.currentTitle!) egg is \(eggTimes[sender.currentTitle!]!) seconds.")
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.setProgress(Float(secondsPassed) / Float(totalTime), animated: true)
        } else {
            let path = Bundle.main.path(forResource: "alarm_sound", ofType: ".mp3")
            let url = URL(fileURLWithPath: path!)

            do {
                eggDoneSound = try AVAudioPlayer(contentsOf: url)
                eggDoneSound?.play()
            } catch {
                print("Audio File Not Found")
            }
            timer.invalidate()
        }
    }
}

