import UIKit

extension Double {
    func round(to places: Int){
        print(places)
        let precisionNumber = pow(10, Double(places))
        var n = self
        n = n * precisionNumber
        n = n.rounded()
        n = n / precisionNumber
        print(n)
        
    }
}

extension UIButton {
    func makeCircular() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
    }
}


var myDouble = 3.14159
myDouble.round()
print("fuck")


myDouble.round(to: 3)

var myButton =  UIButton(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
myButton.backgroundColor = .red
myButton.makeCircular()


let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
button.backgroundColor = .red

button.layer.cornerRadius = 25
button.clipsToBounds = true


