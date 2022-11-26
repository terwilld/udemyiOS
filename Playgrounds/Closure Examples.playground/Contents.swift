import UIKit



func calculator(n1: Int, n2: Int, operation: (Int,Int) -> Int) -> Int {
    let result = operation(n1,n2)
    print("inside calculator: \(result)")
    return result
}

func add(no1: Int, no2: Int) -> Int {
    print("Inside Add: \(no1 + no2)")
    return no1 + no2
}

func multiply(no1: Int, no2: Int) -> Int {
    print("Inside Multiple: \(no1 * no2)")
    return no1 * no2
}





var test = calculator(n1: 2, n2: 7,operation: add)
print(test)
test = calculator(n1: 2, n2: 7, operation: multiply)
print(test)

var test2 = calculator(n1: 2, n2: 7, operation: { (no1: Int, no2: Int) -> Int in print("Inside multiply Closure Call: \(no1 * no2)"); return no1 * no2 } )
print(test2)



var array = [6,2,3,9,4,1]
var array2 = [6,2,3,9,4,1]


func addOne (n1: Int) -> Int {
    return n1 + 1
}

array = array.map(addOne)
print(array)

var test3 = array2.map({$0+10})
print(test3)
