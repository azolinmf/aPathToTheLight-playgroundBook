
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Instantiates a live view and passes it to the PlaygroundSupport framework.
//

import UIKit
import BookCore
import PlaygroundSupport

// Instantiate a new instance of the live view from BookCore and pass it to PlaygroundSupport.
let viewScene = CutsceneViewController()
viewScene.preferredContentSize = UIScreen.main.bounds.size
PlaygroundPage.current.liveView = viewScene

//PlaygroundPage.current.assessmentStatus = .pass(message: "Oiii")
//PlaygroundPage.current.assessmentStatus = .fail(hints: ["oiiii"])


//self.preferredContentSize = UIScreen.main.bounds.size
