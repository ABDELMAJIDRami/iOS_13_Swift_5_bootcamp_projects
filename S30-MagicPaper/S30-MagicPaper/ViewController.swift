//
//  ViewController.swift
//  S30-MagicPaper
//
//  Created by user183479 on 1/4/21.
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
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "NewsPaperImages", bundle: Bundle.main) {
            configuration.trackingImages = trackedImages
            configuration.maximumNumberOfTrackedImages = 1
            print("Images found")
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
        let node = SCNNode()
        if let imageAnchor = anchor as? ARImageAnchor {
            let videoNode = SKVideoNode(fileNamed: "harrypotter.mp4") // when we were using images we were ignoring the extension. But when working with SKVideoNode, make sure to write the fullname including extension
            videoNode.play()
            // this videoNode is a SpriteKit videoNode -> we need to add it into a sceneKit element, so that we can place the sceneKit element into our SceneView session.
            let videoScene = SKScene(size: CGSize(width: 480, height: 360))   // the root node for all Sprite Kit objects displayed in a view. Allow us to display Sprote Kit objects. Now, this width and height doesn't have to be precise. It's just a guess of the width and height in pixels of your video. So, say, if you have a 720p video, then it would be 720 in height by 1080 by width. So in our case, our video is actually a lot smaller than that. Now, because we're using a 360p video in resolution, that means that it has a width of 480 by 360. So that's what we'll put as the size for our SKScene.
            videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
            videoScene.xScale = -1.0  // scaling it negatively will reverse the image to make it flip in the vertical Y axis
            videoScene.addChild(videoNode)  // ready for display in 2D. assign it as a material that will cover our plan which is a 2D object
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            plane.firstMaterial?.diffuse.contents = videoScene
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            node.addChildNode(planeNode)
        }
        return node
    }
}
