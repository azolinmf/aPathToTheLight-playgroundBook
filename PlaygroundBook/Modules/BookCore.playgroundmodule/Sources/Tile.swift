//
//  Tile.swift
//  BookCore
//
//  Created by Maria Fernanda Azolin on 12/05/20.
//

import Foundation
import SpriteKit

class Tile {
    
    //var tile = SKShapeNode(rectOf: CGSize(width: 20, height: 20))
    var tile = SKSpriteNode(imageNamed: "nebula")
    var isPlayer = false
    var isObstacle = false
    var isTarget = false
    var alreadyVisitedNode = false
    var fCost = 999.0
    var gCost = 0.0
    var hCost = 0.0
    var currentTile = false
    var isOnOpenList = false
    var id = -1
    var parentId = 0
    var x = 0
    var y = 0

}

