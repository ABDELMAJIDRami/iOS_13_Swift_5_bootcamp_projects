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

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
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
        
        sceneView.autoenablesDefaultLighting = true
        
        // Create a new scene
        // let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        // sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if ARWorldTrackingConfiguration.isSupported {
            // Create a session configuration
            let configuration = ARWorldTrackingConfiguration()

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
}
