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
    let softTime = 5
    let mediumTime = 7
    let hardTime = 12
    let eggTimes = ["Soft": 3, "Medium": 4,"Hard": 7 ]
    var counter = 30
    var selectedValue = 30
    var ratioDone : Float = 0.0
    var timer = Timer()
    var player: AVAudioPlayer?

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        /*
        if (hardness == "Soft"){
            print(softTime)
        }
        if (hardness == "Medium"){
            print(mediumTime)
        }
        if (hardness == "Hard"){
            print(hardTime)
        }
        print("dict test")
         */
//        print(eggTimes[hardness]!)
        let result = eggTimes[hardness]!
//        print("\(result) mi until it is done")
        counter = result
        selectedValue = result
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @objc func updateCounter() {
        //example functionality
        if counter > 0 {
            print("\(counter) seconds until the egg is done")
            print(selectedValue)
            ratioDone = (Float(selectedValue - counter)/Float(selectedValue))
            print(ratioDone)
            counter -= 1
            progressBar.progress = ratioDone
        }else{
            ratioDone = 1.0
            progressBar.progress = ratioDone
            print("done")
            timer.invalidate()
            mainLabel.text = "Done"
            playSound()
        }
    }
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
       
        
    }
}





