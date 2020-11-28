func calculator (n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(n1, n2)
}

// named func
func multiply (no1: Int, no2:Int) -> Int {
    return no1 * no2
}
calculator(n1: 3, n2: 3, operation: multiply(no1:no2:))
calculator(n1: 3, n2: 3, operation: multiply)


// closure
// 1st variation
calculator(n1: 3, n2: 4, operation: {(no1: Int, no2: Int) -> Int in return no1 * no2})

// 2nd variation
// swift has the ability of infering types based on the value. exp: var a=2; a will be auto assign type Int and the compiler will auto infer and know the type
calculator(n1: 5, n2: 4, operation: {(no1, no2) in return no1 * no2})

// 3rd variation
calculator(n1: 5, n2: 4, operation: {(no1, no2) in no1 * no2})

// 4th variation - Anonymous parameter name.
// In swift, $0 refer to 1st param, $1 to 2nd param ...
calculator(n1: 6, n2: 4, operation: {$0 * $1})

// 5th variation - if the last param is a closure, we can have a Trailing Closure
calculator(n1: 5, n2: 9) {$0 * $1}  // simpler? but maybe not readable for non-swift devs. you always have to strive the balance between simplicity and readabilty

/******************************/
let array = [5, 9, 7, 1, 3, 5]

func addOne (n1: Int) -> Int {
    return n1 + 1
}

array.map(addOne)

array.map({(n1: Int) -> Int in return n1 + 1})

let newArray = array.map{$0 + 1}
print(newArray)

// transform array of Int to array of Strig
let arrayString = array.map{"\($0)"}
print(arrayString)
