import UIKit

var greeting = "Hello, playground"

func isOdd(n: Int) -> Bool {
    if n % 2 == 0 {
        return false
    }
    return true
}

print(isOdd(n: 2))
print(isOdd(n: 3))
