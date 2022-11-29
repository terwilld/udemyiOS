//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by David Terwilliger on 11/23/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    var bmi : BMI?
    
    //        bmiValue = String(format: "%.1f", BMI)
    
    mutating func calculateBMI(height: Float,weight: Float) {
        let bmiValue = weight/(height*height)
        if bmiValue < 18.5 {
//            print("\(bmiValue) underweight")
            //  Some kind of weird swift 13 / xcode bug preventing the color pallet from being created inline.  Those two below should be one.
            let someColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            bmi = BMI(value: bmiValue, advice: "Eat more Pies", color: someColor )
        } else if bmiValue < 25.0 {
            let someColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
//            print("\(bmiValue) normal")
            bmi = BMI(value: bmiValue, advice: "Fit as a Fiddle", color: someColor )
        } else {
            let someColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
//            print("\(bmiValue) Overweight")
            bmi = BMI(value: bmiValue, advice: "Eat less Pies", color: someColor )
        }
        
        
        //bmi = BMI(value: bmiValue, advice: <#T##String#>, color: <#T##UIColor#>)
    }
    func getBMIValue() -> String {
        let bmiTo1DecimalPlace = String(format: "%.1f", bmi?.value ?? 0.0)  // Nil Coalescing  5 ways to really deal with optonals
        return bmiTo1DecimalPlace
    }

    func getAdvice() -> String {
        //let bmiTo1DecimalPlace = String(format: "%.1f", bmi?.value ?? 0.0)  // Nil Coalescing  5 ways to really deal with optonals
        //return bmiTo1DecimalPlace 
        return bmi?.advice ?? "No Advice Found"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ??  #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    }
    
    
    
}
