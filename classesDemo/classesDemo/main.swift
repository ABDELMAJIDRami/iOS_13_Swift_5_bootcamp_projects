
let skeleton = Enemy()
print(skeleton.health)
skeleton.move()
skeleton.attack()

let dragon = Dragon()
dragon.attack() // inherit from Enemy
dragon.move()
dragon.wingSpan = 5
