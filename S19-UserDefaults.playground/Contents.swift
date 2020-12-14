import UIKit

let defaults = UserDefaults.standard    // singleton instance

let dictionaryKey = "myDictionary"

// persist data
defaults.set(0.24, forKey: "Volume")    // exp: set volume at startup
defaults.set(true, forKey: "MusicOn")
//defaults.set(<#T##value: Any?##Any?#>, forKey: <#T##String#>) // set any object (struct, string, Date, int, ...) that cast the result when u read it
defaults.set("Rami", forKey: "PlayerName")
defaults.set(Date(), forKey: "AppLastOpenedByUser")
defaults.set([1, 2, 3], forKey: "myArray")
defaults.set(["name": "Rami"], forKey: dictionaryKey)


// read data
let volume = defaults.float(forKey: "Volume")
let isMusicOn = defaults.bool(forKey: "MusicOn")
let appLastOpen = defaults.object(forKey: "AppLastOpenedByUser")    // grabs an object of any datatype -> we can dowscast it
let myArray = defaults.array(forKey: "myArray") as! [Int] // the return type of defaults.array is optional array: [any]? => downcast it
let myDictionary = defaults.dictionary(forKey: dictionaryKey) as! [String: String]
