//
//  ViewController.swift
//  S28-ARRuler
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
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]  // we will use the auto detected featurePoints to figure out which parts of the scene are a continuous surface and be able to measure something on that surface
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchLocation = touches.first?.location(in: sceneView) {
            let hitTestResults = sceneView.hitTest(touchLocation, types: .featurePoint)  /// perform a hitTest and see if it corresponds to a feature point. So as Xcode explains, the .featurePoint ResultType is a point automatically identified by ARKit as a part of a continuous surface, but without a corresponding anchor. So we're not interested here in detecting planes or going into the planeAnchors or 3D anchors, we're actually just interested in using the code inside ARKit to detect continuous surfaces. And this will give us the 3D location of a continuous surface I'm tapping on if it exists. (i think even if it is nota continuous surface we can still grab a featurePoint/3d point and do the measure).
            // hitTestResults is a locations in 3d space / inspect .hitTest
            if let hitResult = hitTestResults.first {
                addDot(at: hitResult)
            }
        }
    }
    
    func addDot(at hitResult: ARHitTestResult) {
        let dotGeometry = SCNSphere(radius:  0.005)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        
        dotGeometry.materials = [material]
        
        let dotNode = SCNNode(geometry: dotGeometry)
        dotNode.position = SCNVector3(
            x: hitResult.worldTransform.columns.3.x,
            y: hitResult.worldTransform.columns.3.y,
            z: hitResult.worldTransform.columns.3.z
        )
        sceneView.scene.rootNode.addChildNode(dotNode)
    }
}
