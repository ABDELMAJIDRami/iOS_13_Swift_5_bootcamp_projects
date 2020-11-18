
class Dragon: Enemy {
    var wingSpan = 2
    
    override func move() {
        print("Fly forward")
    }
    
    override func attack() {
        super.attack()
        print("Spits Fire. does 10 damage.")
    }
}
