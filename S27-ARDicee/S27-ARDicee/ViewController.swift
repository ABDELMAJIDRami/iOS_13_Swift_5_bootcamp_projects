//
//  ViewController.swift
//  S27-ARDicee
//
//  Created by user183479 on 12/31/20.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    var diceArray = [SCNNode]() // empty array of SCNNode objects

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // REMOVE THIS IN PRODUCTION
        // inspect vars to understand - there is many other options to append to this array
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]

        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        /*
        // inspect each variable/object to understand it. All objects are preceded with SCN cz they are imported from ScenceKit.
        // let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
        let sphere = SCNSphere(radius: 0.2)
        
        let material = SCNMaterial()
        
        // material.diffuse.contents = UIColor.blue    // .contents: Animatable.
        material.diffuse.contents = UIImage(named: "art.scnassets/moon.jpg")
        
        sphere.materials = [material]     // array of materials cz an object can have multiple materials: u can change the diffuse, the shininess, the metallicness, the texture of it...
        
        let node = SCNNode()    // point in 3D space
        
        node.position = SCNVector3(x: 0, y: 0.1, z: -0.5)   // animatable. SeeGoodNotes.
        
        node.geometry = sphere    // assin that node an object/geometry to display
        
        sceneView.scene.rootNode.addChildNode(node) // check GoodNotes.
        */
        
        sceneView.autoenablesDefaultLighting = true
        
         // Create a new scene
            // let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
        
        // if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true) {    // Returns the first node in the node’s child node subtree with the specified name. recursively: true to search the entire child node subtree, or false to search only the node’s immediate children.
        // diceNode.position = SCNVector3(x: 0, y: 0, z: -0.1)
        // sceneView.scene.rootNode.addChildNode(diceNode)
        //}
        
        // Set the scene to the view
         // sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if ARWorldTrackingConfiguration.isSupported {
            // Create a session configuration
            let configuration = ARWorldTrackingConfiguration()
            
            configuration.planeDetection = .horizontal

            // Run the view's session
            sceneView.session.run(configuration)
        } else {
            // we can display a message to a user regarding the AR experience on his device
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - Dice Rendering Methods
    
    // called when touch is detected in view or Window and convert user touches into real word location(x,y,z) using ARKit.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first { // check if there endeed were touches and this method wasn't called min error
            let touchLocation = touch.location(in: sceneView)
            
            let results = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
            
            
            if let hitResult = results.first {
                addDice(atLocation: hitResult)
            }
        }
    }
    
    func addDice(atLocation location: ARHitTestResult) {
        // Create a new scene
        let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
       
        if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true) {    // Returns the first node in the node’s child node subtree with the specified name. recursively: true to search the entire child node subtree, or false to search only the node’s immediate children.
            diceNode.position = SCNVector3(
                x: location.worldTransform.columns.3.x,
                y: location.worldTransform.columns.3.y + diceNode.boundingSphere.radius,
                z: location.worldTransform.columns.3.z
            )
            sceneView.scene.rootNode.addChildNode(diceNode)
                                
            // animate each dice we add
            roll(dice: diceNode)
        }
    }
    
    func roll(dice: SCNNode) {
        // calculate rotation; exp: 1 rotation = 1 * 90degree, 2 dice rotation = 2 * 90degree -> convert it to radian
        // we didn't rotate around Y axis cz it is a vertical axis; like torsion, the upper face won't change
        let randomX = Float(arc4random_uniform(4) + 1) * (Float.pi / 2) // at max it will be equal to 4*90=1 full 360 rotation
        let randomZ = Float(arc4random_uniform(4) + 1) * (Float.pi / 2)

        dice.runAction(
            SCNAction.rotateBy(x: CGFloat(randomX * 5), // exp: 270 * 5 -> more rotation
                               y: 0,
                               z: CGFloat(randomZ * 5),
                               duration: 0.5
            )
        )
    }
    
    func rollAll() {
        if !diceArray.isEmpty {
            for dice in diceArray {
                roll(dice: dice)
            }
        }
    }
    
    // linked to button in storyboard to refresh all dices
    @IBAction func rollAgain(_ sender: UIBarButtonItem) {
        rollAll()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        // shake device
        rollAll()
    }
    
    @IBAction func removeAllDice(_ sender: UIBarButtonItem) {
        if !diceArray.isEmpty {
            for dice in diceArray {
                dice.removeFromParentNode()
            }
        }
    }
    
    // MARK: - ARSCNViewDelegateMethods
    
    // ARSCNViewDelegate method: And as it says, it tells the delegate, which is this current view controller, that a SceneKit node corresponding to a new AR anchor(exp: a horizontal anchor(surface)) has been added to the scene. It means that it's detected a horizontal surface and it's given that detected surface a width and a height which is an AR anchor so that we'll be able to use it to place things or to visualize it.
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}

        let planeNode = createPlan(withPlaneAnchor: planeAnchor)
        
        node.addChildNode(planeNode)
    }
    
    // MARK: - Plane Rendering Methods
    
    func createPlan(withPlaneAnchor planeAnchor: ARPlaneAnchor) -> SCNNode {
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))  // x * z NOT x * y -- inspect "extent": the last 3 lines says that y-component in always 0 cz it is a flat horizontal plan/anchor
        
        let planeNode = SCNNode()
        
        planeNode.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
        
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)  // see GoodNotes
        
        // grid.png is the asset that Apple provided in their example for us to be able to visualize these plans.
        // .png files type have transparencies and we can see the materials underneeath!! so we can see through them.
        let gridMaterial = SCNMaterial()
        
        gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
        
        plane.materials = [gridMaterial]
        
        planeNode.geometry = plane
        
        return planeNode
    }
}
