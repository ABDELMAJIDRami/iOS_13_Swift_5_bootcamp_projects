//
//  ViewController.swift
//  S29-Poke3D
//
//  Created by user183479 on 1/3/21.
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sceneView.autoenablesDefaultLighting = true
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()  // A configuration you use when you just want to track known images using the device's back camera feed.
        
        // specify images you want AR to track (inspect elements to understand)
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main) {
            // we did let vinding bcz the app might look for something called "Pokemon Cards" and don't find it in the main bundle
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 1
            print("Images Successfully Added/Loaded")
        }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        // anchor is the thing that was detected - in our case the image (ARTimageTrackingConfiguration)
        // and the node is going to be a 3D object that we're going to provide in response to detecting the anchor. This fct expect a return/output to be rendered on screen.
        // So When the image gets detected, this method will get called and we can look at the image that got detected. And in response, we can provide a 3D object to be rendered into the screen.
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor { // if this anchor is of type plane or featurepoint -> skip and do nothing
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)  //instead of me hardcoding the dimensions
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2  // -Float.pi / 2
            node.addChildNode(planeNode)
            
            if let pokeScene = SCNScene(named: "art.scnassets/eevee.scn") {
                if let pokeNode = pokeScene.rootNode.childNodes.first {
                    pokeNode.eulerAngles.x = .pi / 2
                    planeNode.addChildNode(pokeNode)
                }
            }
        }
        
        return node
    }
}
