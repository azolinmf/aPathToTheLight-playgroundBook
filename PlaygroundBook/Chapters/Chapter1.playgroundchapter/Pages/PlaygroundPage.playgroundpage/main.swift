/*:
 
 # Path finding algorithms

  * Note: **A-star**: this is a complete and optimal search algorithm. Type "A*" in the editable code area to use it.
 */
    
/*:
 
 * Note: **Dijkstra**: this is a complete search algorithm. Type "Dijkstra" in the editable code area to use it.
 */

//#-hidden-code

import PlaygroundSupport
import SpriteKit
import UIKit
import BookCore


let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 512, height: 768))
if let scene = GameScene(fileNamed: "GameScene") {

    scene.scaleMode = .aspectFit
    //#-end-hidden-code
    
scene.algorithm = /*#-editable-code*/"A*" /*#-end-editable-code*/
     
    //#-hidden-code

    sceneView.presentScene(scene)
}

PlaygroundPage.current.liveView = sceneView
PlaygroundPage.current.needsIndefiniteExecution = true
//#-end-hidden-code
