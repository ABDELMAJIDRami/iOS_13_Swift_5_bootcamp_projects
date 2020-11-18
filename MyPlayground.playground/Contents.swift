struct Town {
    let name: String
    var citizens: [String]
    var resources: [String : Int]
    
    init(citizens: [String], name:String, resources: [String : Int]) {
        self.name = name
        self.citizens = citizens
        self.resources = resources
    }
    
    mutating func harvestRice() {
        resources["Rice"] = 100
    }
}

var myTown = Town(citizens: ["Andegla", "Jack"], name: "Angelland", resources: ["wood": 75])

myTown.citizens.append("Rami")
print("People of \(myTown.name): \(myTown.citizens)")

myTown.harvestRice()
print(myTown.resources)
