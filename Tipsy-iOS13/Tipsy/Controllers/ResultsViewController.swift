//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by David Terwilliger on 11/23/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var billTotal: Double = 0.0
    var tip = 0.10
    var numberOfPeople = 2
//    var
    override func viewDidLoad() {
        super.viewDidLoad()
        print(billTotal)
        print("inside view did load screen 2")
        print(tip)
        print(numberOfPeople)
        totalLabel.text = String(billTotal)
        let pct = Int(tip * 100)
        settingsLabel.text = "Split between \(numberOfPeople) people, with \(pct)% tip."
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
