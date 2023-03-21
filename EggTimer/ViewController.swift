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
//    let softTime = 3
//    let mediumTime = 5
//    let hardTime =
    @IBOutlet weak var eggStatus: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!

    var secondsRemaining = 60
    var timer = Timer()
    var secondsPassed = 0
    var totalTime = 0
    var progressTime = 0.0
    
    
    let hardnessLevel = ["Soft": 300, "Medium": 500, "Hard": 800]
    
    var player: AVAudioPlayer?
    
    @IBAction func hardnessButton(_ sender: UIButton) {
        eggStatus.text = "How do you like your eggs?"
        timer.invalidate()
        secondsPassed = 0
        progressBar.progress = Float(secondsPassed)
        
        let hardness = sender.currentTitle!
        eggStatus.text = hardness
        
        totalTime = hardnessLevel[hardness]!
        secondsRemaining = totalTime
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
    }
    @objc func updateTime() {
        if secondsPassed < totalTime {
            
            let percentageProgress =  Float(secondsPassed) / Float(totalTime)
            
            progressBar.progress = percentageProgress
            
            secondsPassed += 1
        } else {
            timer.invalidate()
            eggStatus.text = "Done!"
            progressBar.progress = Float(secondsPassed)
            playSound()
        }
    }
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()

    }

}
