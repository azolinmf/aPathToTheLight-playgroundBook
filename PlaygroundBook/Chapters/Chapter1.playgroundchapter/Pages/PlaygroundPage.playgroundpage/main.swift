/*:
 
 # Path finding algorithms
 
 Complete algorithms **always** find the target, but some are more efficient than others.
 A search algorithm can be optimal and always lead to the shortest path to the target.


  * Note: **Breadth-first search** is a complete search algorithm.*/

/*:
 
 * Note: **Dijkstra** is a complete search algorithm.*/

/*:

* Note: **A-star** is a complete and optimal search algorithm. */


//#-hidden-code

import PlaygroundSupport
import SpriteKit
import UIKit
import BookCore


let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 512, height: 768))
if let scene = GameScene(fileNamed: "GameScene") {

    scene.scaleMode = .aspectFit
    sceneView.presentScene(scene)
    
}

PlaygroundPage.current.liveView = sceneView
PlaygroundPage.current.needsIndefiniteExecution = true
//#-end-hidden-code
