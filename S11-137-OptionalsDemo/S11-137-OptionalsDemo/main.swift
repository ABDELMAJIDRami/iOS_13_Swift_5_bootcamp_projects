/*
 String and String? are completly different types
 */

let myOptional: String?

myOptional = nil
//myOptional = "Rami"

// 1- Force Unwarap
// let text: String = myOptional!  //will through error at runtime if myOptional is null


// 2- check for bil value - then unwarp // we always need to use ! to force unwrap
//if myOptional != nil {
//    let text: String = myOptional!
//} else {
//    print("My Optional was found to be nil")
//}


// 3- Optional Binding
//if let safeOptional = myOptional {
//    let text: String = safeOptional
//    print(text)
//} else {
//    print("My Optional was found to be nil")
//}


// 4- Nil Coalescing Operator - use default value in cas of nil
//let text: String = myOptional ?? "I am the defaut value"
//print(text)


// 5- Optional chaning in case of optuonal struct or class
struct MyOptional {
    var property = 123
    func method() {
        print("I am the struct's method")
    }
}

let structOptional: MyOptional? // datatype no instance

structOptional = MyOptional()

structOptional?.method()


