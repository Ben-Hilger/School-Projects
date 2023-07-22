//
//  GameViewController.swift
//  Ball Maze
//
//  Created by Ben Hilger on 5/22/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    var prevPosition : SCNVector3!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene(named: "art.scnassets/Test.scn")!
        let ball = scene.rootNode.childNode(withName: "Ball", recursively: true)!
        prevPosition = ball.position
        
        let box = SCNScene(named: "art.scnassets/MainBlock.scn")!.rootNode.childNode(withName: "box", recursively: true)!

        let floor = MazeFloor(box: box, numOfRooms: 20, size: 20)
        // create and add a camera to the scene
        let cameraNode = scene.rootNode.childNode(withName: "camera", recursively: true)!
        cameraNode.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(node: cameraNode, options: nil))
        scene.rootNode.addChildNode(cameraNode)
 
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)

        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
        ball.physicsBody?.applyForce(SCNVector3(x: 10, y: 0,z: 0), asImpulse: false)
        
        projectMaze(floor: floor)
    }
    
    func projectMaze(floor : MazeFloor){
        let scene = (self.view as! SCNView).scene!
        floor.printMaze(scene: scene, offset: 0)
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            // get its material
            let material = result.node.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.red
            
            SCNTransaction.commit()
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func adjustCamera(){
//        let scene = (self.view as! SCNView).scene
//        let camera = scene?.rootNode.childNode(withName: "camera", recursively: true)!
//        let ball = scene?.rootNode.childNode(withName: "Ball", recursively: true)!
//
//        let xDiff = (ball?.position.x)!-prevPosition.x
//        let zDiff = (ball?.position.z)!-prevPosition.z
//
//        camera?.position = SCNVector3(x: (camera?.position.x)!+xDiff, y: (camera?.position.y)!, z: (camera?.position.z)!+zDiff)
//        prevPosition = ball?.position
    }
    
}
