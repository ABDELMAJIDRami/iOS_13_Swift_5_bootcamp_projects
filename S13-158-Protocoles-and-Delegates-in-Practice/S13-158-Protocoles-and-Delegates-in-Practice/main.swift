protocol AdvancedLifeSupport {
    func performCPR()
}

class EmergencyCallHandler {
    var delegate: AdvancedLifeSupport?  // optional - in case struct didn't implement the method - nothing happens
    
    func assessSituation() {
        print("Can you tell me what happened?")
    }
    
    func medicalEmergency() {
        delegate?.performCPR()
    }
}

struct Paramedic: AdvancedLifeSupport {
    init(handler: EmergencyCallHandler) {   // our struct receives an instance of EmergencyCallHandler. exp: So when the paramedic goes on shift(when the class is initialized, it get told who the handler is), the first thing they do is they pick up the bleep or the pager(alarm like tool) and they set the handler's delegate property as themselves. And through this line of code, they've said, "I am going to listen for notifications when I have to perform CPR from the emergency call handler. I am the delegate
        handler.delegate = self
    }
    
    func performCPR() {
        print("The paramedic does chest compressions, 30 per second.")
    }
}

class Doctor: AdvancedLifeSupport {
    init(handler: EmergencyCallHandler) {
        handler.delegate = self
    }
    
    func performCPR() {
        print("The doctor does chest compressions, 30 per second")
    }
    
    func useStethescope() {
        print("Listening for heart sounds")
    }
}

class Surgeon: Doctor { // inherit Doctor so it supports AdvancedLifeSupport and have access to performCPR func by default
    override func performCPR() {
        super.performCPR()
        print("Sings staying alive by the BeeGess")
    }
    
    func useElectricDrill() {
        print("Whirr...")
    }
}

// after we created our protocols and blueprints. It is time to create instances
let angela = EmergencyCallHandler()
//let rami = Paramedic(handler: angela)   // now angela.delegate = rami
let rami = Surgeon(handler: angela) // so check console prints  - in changes but angela code doesn't change when delegate change. So EmergencyCallHandler, which is taking the role of UITextField, is independent and unaware of the class which is going to perform the CPR

angela.assessSituation()    // anf if it is an emrgency situation(a situation when a user want to dismiss/submit a textfield) -> call the delegate imlemented fct and do want it want - ask for permissoins
angela.medicalEmergency()   // --> rami.performCPR()
