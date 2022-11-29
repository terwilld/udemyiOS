//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    var storyBrain = StoryBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
        let currentStory = storyBrain.stories[storyBrain.storyNumber]
        print("Printing current story in view did load \(currentStory)")
        updateUI(currentStory:currentStory)
    }

    @IBAction func choiceMade(_ sender: UIButton) {
        var currentStory = storyBrain.nextStory(userChoice: sender.titleLabel!.text!)
        updateUI(currentStory:currentStory)
        }
    
    func updateUI(currentStory: Story){
        print("Inside of update UI \(currentStory)")
        storyLabel.text = currentStory.title
        choice1Button.setTitle(currentStory.choice1, for: .normal)
        choice2Button.setTitle(currentStory.choice2, for: .normal)
        
    }
        
}



