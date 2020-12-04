import Foundation

let fruits = ["Apple", "Pear", "Orange"]
//let fruits: Array = ["Apple", "Pear", "Orange"] // loop in order - less efficienty
//let fruits: Set = ["Apple", "Pear", "Orange"] // more efficient type of collection but loop not in order
let contacts = ["Adam": 123456789, "James": 987654321, "Amy": 564278913]    // dictionnary
let word = "zxcvbnmlkhgfdsaqwertyuiopj"
let halfOpenRange = 1..<5
let ClosedRange = 1...5

for fruit in fruits {
    print(fruit)
}

print("   ")

for person in contacts {
    print(person)
    print(person.key)
    print(person.value)
}

print("   ")

for number in halfOpenRange {
    print(number)
}

print("   ")

for _ in ClosedRange {
    print("Batata everywhere")
}

/* While Loops: will still run until the condition become false. The program may fail if it stuck in a infinite loop */

var now = Date().timeIntervalSince1970  // import Fondation for it to work
var oneSecondFromNow = now - 10

while now > oneSecondFromNow {
    print("Waiting...")
    oneSecondFromNow += 1
}
