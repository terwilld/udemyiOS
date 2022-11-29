import UIKit

var greeting = "Hello, playground"


class Assignment {
    
    
    func fibonacci(n: Int) {
        var results = [0,1]
        //Write your code here.
        print(results.last!)
        results += [2]
        print(results.last!)
        
    }
}


func fibonacci(n: Int) {
    var results = [0,1]
    var currentCount = results.count
    var lastNumber = results[currentCount - 1 ]
    var secondToLastNumber = results[currentCount - 2]
    while results.count < n {
        lastNumber = results[currentCount - 1 ]
        secondToLastNumber = results[currentCount - 2]
        results += [lastNumber+secondToLastNumber]
        currentCount = results.count
    }
    print(results)
}

fibonacci(n: 10)


