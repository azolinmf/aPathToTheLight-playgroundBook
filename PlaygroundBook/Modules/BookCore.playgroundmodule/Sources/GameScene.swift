//
//  GameScene.swift
//  BookCore
//
//  Created by Maria Fernanda Azolin on 12/05/20.
//

import PlaygroundSupport
import SpriteKit
import UIKit
import AVFoundation


public class GameScene: SKScene {
        
    
    //map and general app variables
    var tileArray: [[Tile]] = [[Tile]]()
    var posX = 0
    var posY = 0
    var marginX = 42
    var marginY = 75
    let rows = 19
    let columns = 15
    let nodeSize = 30
    var mapSize = 0
    var iterations = 0
    
    //interactable
    let startButton = SKSpriteNode(imageNamed: "startButton")
    let clearButton = SKSpriteNode(imageNamed: "clearButton")
    let aStarButton = SKSpriteNode(imageNamed: "leverDown")
    let dButton = SKSpriteNode(imageNamed: "leverUp")
    let bfsButton = SKSpriteNode(imageNamed: "leverUp")
    let upSpeedButton = SKSpriteNode(imageNamed: "up")
    let downSpeedButton = SKSpriteNode(imageNamed: "down")
    let speedPanel = SKSpriteNode(imageNamed: "speed1")
    
    let debug = SKLabelNode(text: "debug")
    var lastTouchPosition = CGPoint(x: 0, y: 0)
    
    //all searches variables
    var playerPos = CGPoint(x: 5, y: 10)
    var targetPos = CGPoint(x: 12, y: 12)
    var alreadyFoundTarget = false
    var targetId = 0
    var playerId = 0
    var movingPlayer = false
    var movingTarget = false
    var movableNode : SKNode?
    var movablePlayer = SKSpriteNode(imageNamed: "planet")
    var movableStar = SKSpriteNode(imageNamed: "star")
    
    //A* variables
    var lowestCostId = 0
    var lowestCostIndex = 0
    var openList : [Tile] = [Tile]()
    var closedList : [Tile] = [Tile]()
    typealias Pos = (x: Int, y: Int)
    
    //Dijkstra and Breadth-first variables
    var unexploredList : [Tile] = [Tile]()
    
    //playground pages variables
    public var algorithm : String = "A*"
    
    //drawing variables
    var paintIdList : [Int] = [Int]()
    var pathIdList : [Int] = [Int]()
    var shouldDraw = false
    var shouldPaint = false
    var drawingSpeed = 0.2
    var drawingSpeed1 = 0.2
    var drawingSpeed2 = 0.10
    var drawingSpeed3 = 0.05
    var timer : Timer? = Timer()
    var nodeInitialOpacity = CGFloat(1.0)
    var nodeVisitedOpacity = CGFloat(0.0)
    
    var hintControl = 0
    var movedPlayerOrTarget = false
    var placedObstacles = false
    var impossiblePath = false
    var changedAlgorithm = false
    
    var music: AVAudioPlayer!
    
    
    override public func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0, y: 0)
//        debug.position = CGPoint(x: 50, y: 50)
//        self.addChild(debug)
        self.addChild(movablePlayer)
        self.addChild(movableStar)
        
        var id = 0
        for column in 0...columns-1 {
            tileArray.append([Tile]())
            for row in 0...rows-1 {
                
                let square = Tile()
                
                posX = marginX + column * nodeSize
                posY = marginY + row * nodeSize
                
                square.tile.alpha = nodeInitialOpacity
                square.tile.position = CGPoint(x: posX, y: posY)
                square.tile.size = CGSize(width: nodeSize, height: nodeSize)
                
                square.id = id
                square.x = column
                square.y = row
                id += 1
                
                self.tileArray[column].append(square)
                self.addChild(square.tile)
                
            }
        }
        
        setPlayerAndTarget()
        createButtons()
        playMusic()
        
        mapSize = columns*rows
    }
    
    func createButtons() {
        
        startButton.position = CGPoint(x: 412, y: 716)
        startButton.zPosition = 1
        startButton.name = "startButton"
        startButton.isUserInteractionEnabled = false
        self.addChild(startButton)
        
        clearButton.position = CGPoint(x: 433, y: 671)
        clearButton.zPosition = 1
        clearButton.name = "clearButton"
        clearButton.isUserInteractionEnabled = false
        self.addChild(clearButton)

        aStarButton.position = CGPoint(x: 178, y: 707)
        aStarButton.zPosition = 1
        aStarButton.name = "aStarButton"
        aStarButton.isUserInteractionEnabled = false
        self.addChild(aStarButton)
        
        dButton.position = CGPoint(x: 250, y: 711)
        dButton.zPosition = 1
        dButton.name = "dButton"
        dButton.isUserInteractionEnabled = false
        self.addChild(dButton)
        
        bfsButton.position = CGPoint(x: 318, y: 711)
        bfsButton.zPosition = 1
        bfsButton.name = "bfsButton"
        bfsButton.isUserInteractionEnabled = false
        self.addChild(bfsButton)
        
        speedPanel.position = CGPoint(x: 85, y: 707)
        speedPanel.zPosition = 1
        speedPanel.name = "speedPanel"
        speedPanel.isUserInteractionEnabled = false
        self.addChild(speedPanel)
        
        upSpeedButton.position = CGPoint(x: 118, y: 707)
        upSpeedButton.zPosition = 1
        upSpeedButton.name = "upSpeedButton"
        upSpeedButton.isUserInteractionEnabled = false
        self.addChild(upSpeedButton)
        
        downSpeedButton.position = CGPoint(x: 52, y: 707)
        downSpeedButton.zPosition = 1
        downSpeedButton.name = "downSpeedButton"
        downSpeedButton.isUserInteractionEnabled = false
        self.addChild(downSpeedButton)
        
        
        
    }
    
    func resetSearchVariables() {
        
        for column in 0...tileArray.count-1 {
            for row in 0...tileArray[0].count-1 {
                tileArray[column][row].alreadyVisitedNode = false
                tileArray[column][row].fCost = 999.0
                tileArray[column][row].gCost = 0.0
                tileArray[column][row].hCost = 0.0
                tileArray[column][row].currentTile = false
                tileArray[column][row].isOnOpenList = false
                tileArray[column][row].tile.texture = SKTexture(imageNamed: "nebula")
                tileArray[column][row].tile.size = CGSize(width: nodeSize, height: nodeSize)
                tileArray[column][row].tile.alpha = nodeInitialOpacity
                tileArray[column][row].isObstacle = false
                tileArray[column][row].parentId = 0
            }
        }
        
        iterations = 0
        impossiblePath = false
        
        unexploredList.removeAll()
        closedList.removeAll()
        openList.removeAll()
        
        setPlayerAndTarget()
        
        alreadyFoundTarget = false
        
        pathIdList.removeAll()
        paintIdList.removeAll()
    }
    
    func animateObstacleAtPos(column: Int, row: Int) {
        let rotate = SKAction.rotate(byAngle: (2 * .pi) , duration: 0.5)
        let growUp = SKAction.scale(to: 1.5, duration: 0.25)
        let growDown = SKAction.scale(to: 1, duration: 0.25)
        let group = SKAction.group([growUp, rotate])
        let sequence = SKAction.sequence([group, growDown])
        
        tileArray[column][row].tile.run(sequence)
    }
    
    func animateTarget(column: Int, row: Int) {
        let fadeIn = SKAction.fadeIn(withDuration: 1.8)
        let fadeOut = SKAction.fadeOut(withDuration: 1.8)
        let sequence = SKAction.sequence([fadeIn, fadeOut])
        let repeatSequence = SKAction.repeatForever(sequence)
        
        tileArray[column][row].tile.run(repeatSequence)
    }
    
    func setPlayerAndTarget() {
        tileArray[Int(playerPos.x)][Int(playerPos.y)].isPlayer = true
        tileArray[Int(playerPos.x)][Int(playerPos.y)].tile.texture = SKTexture(imageNamed: "planet")
        tileArray[Int(playerPos.x)][Int(playerPos.y)].tile.size = CGSize(width: 45, height: 36.8)
        tileArray[Int(playerPos.x)][Int(playerPos.y)].tile.alpha = 1.0
        
        tileArray[Int(targetPos.x)][Int(targetPos.y)].isTarget = true
        tileArray[Int(targetPos.x)][Int(targetPos.y)].tile.texture = SKTexture(imageNamed: "star")
        tileArray[Int(targetPos.x)][Int(targetPos.y)].tile.size = CGSize(width: 60, height: 60)
        animateTarget(column: Int(targetPos.x), row: Int(targetPos.y))
        
        playerId = tileArray[Int(playerPos.x)][Int(playerPos.y)].id
        targetId = tileArray[Int(targetPos.x)][Int(targetPos.y)].id
        
        
        movablePlayer.size = CGSize(width: 45, height: 36.8)
        movablePlayer.position = CGPoint(x: 150, y: 120)
        movablePlayer.isHidden = true
        
        movableStar.size = CGSize(width: 60, height: 60)
        movableStar.position = CGPoint(x: 150, y: 120)
        movableStar.isHidden = true
        
    }
    
    func euclideanDistance(x1 : Double, y1 : Double, x2 : Double, y2 : Double) -> Double {
        return sqrt(pow((x1-x2), 2) + pow((y1-y2), 2))
    }
    
    func autoClear() {
        //when the user plays again whitout first clearing the map
        
        for column in 0...tileArray.count-1 {
            for row in 0...tileArray[0].count-1 {
                if !tileArray[column][row].isObstacle {
                    tileArray[column][row].alreadyVisitedNode = false
                    tileArray[column][row].fCost = 999.0
                    tileArray[column][row].gCost = 0.0
                    tileArray[column][row].hCost = 0.0
                    tileArray[column][row].currentTile = false
                    tileArray[column][row].isOnOpenList = false
                    tileArray[column][row].tile.texture = SKTexture(imageNamed: "nebula")
                    tileArray[column][row].tile.size = CGSize(width: nodeSize, height: nodeSize)
                    tileArray[column][row].tile.alpha = nodeInitialOpacity
                    tileArray[column][row].isObstacle = false
                    tileArray[column][row].parentId = 0
                }
                
            }
        }
        
        iterations = 0
        
        unexploredList.removeAll()
        closedList.removeAll()
        openList.removeAll()
        
        setPlayerAndTarget()
        
        alreadyFoundTarget = false
        
        pathIdList.removeAll()
        paintIdList.removeAll()
    }
    
    func isObstacleAtPos(pos : CGPoint) -> Bool {
        
        let posId = posToId(pos: Pos(Int(pos.x), Int(pos.y)))
        
        for column in 0...tileArray.count-1 {
            for row in 0...tileArray[0].count-1 {
                if tileArray[column][row].id == posId {
                    return tileArray[column][row].isObstacle
                }
            }
        }
        
        return false
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
        if clearButton.contains(pos) {
            resetSearchVariables()
        }
        else if aStarButton.contains(pos) {
            changedAlgorithm = true
            handleTapOnAStar()
        }
        else if dButton.contains(pos) {
            changedAlgorithm = true
            handleTapOnD()
        }
        else if bfsButton.contains(pos) {
            changedAlgorithm = true
            handleTapOnBFS()
        }
        else if upSpeedButton.contains(pos) {
            handleTapOnUpSpeed()
        }
        else if downSpeedButton.contains(pos) {
            handleTapOnDownSpeed()
        }
        else if startButton.contains(pos) {
            hintControl += 1
            checkHintControl()
            
            if alreadyFoundTarget {
                autoClear()
            }
            if !alreadyFoundTarget {
                
                disableUserInteraction(shouldDisable: true)
                var success = true
                switch algorithm {
                case "A*" :
                    success = self.aStar()
                case "Dijkstra" :
                    success = self.dijkstra()
                case "Breadth-first" :
                    success = self.breadthFirst()
                default:
                    success = aStar()
                }
                
                //if the parente id from the taregt is 0, it transversed the map
                let searchSuccess = tileArray[Int(targetPos.x)][Int(targetPos.y)].parentId
                
                if !success || searchSuccess == 0 {
                    impossiblePath = true
                    disableUserInteraction(shouldDisable: false)
                    autoClear()
                    checkHintControl()
                } else { //deu bom a busca
                    createDrawPathList()
                    
                    timer = Timer.scheduledTimer(timeInterval: drawingSpeed, target: self, selector: #selector(GameScene.paintVisitedTile), userInfo: nil, repeats: true)
                }
                
            }
            
        }
//        else if isObstacleAtPos(pos: pos) {
//            handleCleanObstacleAtPos(pos: pos)
//        }
        
    }
    
    func checkHintControl() {
        //numeros completamente arbitrarios fodac o codigo eh meu
        
        if impossiblePath {
            PlaygroundPage.current.assessmentStatus = .pass(message: "It's impossible to reach the shine of the stars like this! Clear the obstacles and try another configuration.")
            return
        }
        
        if hintControl == 4 && !placedObstacles {
            PlaygroundPage.current.assessmentStatus = .pass(message: "Try adding obstacles! Touch and swipe on the map to place them.")
        }
        if hintControl == 2 && !movedPlayerOrTarget && !changedAlgorithm && !placedObstacles {
            PlaygroundPage.current.assessmentStatus = .pass(message: "Let's make this more interesting! Drag and drop to change the planet and target positions.")
        }
        
        if hintControl == 3 && !movedPlayerOrTarget {
            PlaygroundPage.current.assessmentStatus = .pass(message: "Let's make this more interesting! Drag and drop to change the planet and target positions.")
        }
        
        if hintControl >= 5 && !changedAlgorithm {
            PlaygroundPage.current.assessmentStatus = .pass(message: "How about trying another method? Pick a different algorithm.")
            //PlaygroundPage.current.assessmentStatus = .pass(message: "Oiii")
            //PlaygroundPage.current.assessmentStatus = .fail(hints: ["How about trying another method? Pick a different algorithm."], solution: nil)
        }
        
    }
    
    
    func handleCleanObstacleAtPos(pos: CGPoint) {
        let posId = posToId(pos: Pos(Int(pos.x), Int(pos.y)))
        for column in 0...tileArray.count-1 {
            for row in 0...tileArray[0].count-1 {
                if tileArray[column][row].id == posId {
                    tileArray[column][row].isObstacle = false
                    tileArray[column][row].tile.texture = SKTexture(imageNamed: "nebula")
                    tileArray[column][row].tile.size = CGSize(width: nodeSize, height: nodeSize)
                    tileArray[column][row].tile.alpha = nodeInitialOpacity
                }
            }
        }
    }
    
    func handleTapOnDownSpeed() {
        if drawingSpeed == drawingSpeed3 {
            drawingSpeed = drawingSpeed2
            speedPanel.texture = SKTexture(imageNamed: "speed2")
        } else if drawingSpeed == drawingSpeed2 {
            drawingSpeed = drawingSpeed1
            speedPanel.texture = SKTexture(imageNamed: "speed1")
        }
    }
    
    func handleTapOnUpSpeed() {
        
        if drawingSpeed == drawingSpeed1 {
            drawingSpeed = drawingSpeed2
            speedPanel.texture = SKTexture(imageNamed: "speed2")
        } else if drawingSpeed == drawingSpeed2 {
            drawingSpeed = drawingSpeed3
            speedPanel.texture = SKTexture(imageNamed: "speed3")
        }
        
    }
    
    func handleTapOnBFS() {
        if algorithm == "Breadth-first" {
            algorithm = "A*"
            
            bfsButton.texture = SKTexture(imageNamed: "leverUp")
            bfsButton.position = CGPoint(x: bfsButton.position.x, y: bfsButton.position.y + 4)
            
            aStarButton.texture = SKTexture(imageNamed: "leverDown")
            aStarButton.position = CGPoint(x: aStarButton.position.x, y: aStarButton.position.y - 4)
        } else {
            
            bfsButton.texture = SKTexture(imageNamed: "leverDown")
            bfsButton.position = CGPoint(x: bfsButton.position.x, y: bfsButton.position.y - 4)
            
            if algorithm == "A*" {
                aStarButton.texture = SKTexture(imageNamed: "leverUp")
                aStarButton.position = CGPoint(x: aStarButton.position.x, y: aStarButton.position.y + 4)
                
            } else if algorithm == "Dijkstra" {
                dButton.texture = SKTexture(imageNamed: "leverUp")
                dButton.position = CGPoint(x: dButton.position.x, y: dButton.position.y + 4)
            }
            
            algorithm = "Breadth-first"
        }
    }
    
    func handleTapOnD() {
        if algorithm == "Dijkstra" {
            algorithm = "Breadth-first"
            
            dButton.texture = SKTexture(imageNamed: "leverUp")
            dButton.position = CGPoint(x: dButton.position.x, y: dButton.position.y + 4)
            
            bfsButton.texture = SKTexture(imageNamed: "leverDown")
            bfsButton.position = CGPoint(x: bfsButton.position.x, y: bfsButton.position.y - 4)
        } else {
            
            dButton.texture = SKTexture(imageNamed: "leverDown")
            dButton.position = CGPoint(x: dButton.position.x, y: dButton.position.y - 4)
            
            if algorithm == "A*" {
                aStarButton.texture = SKTexture(imageNamed: "leverUp")
                aStarButton.position = CGPoint(x: aStarButton.position.x, y: aStarButton.position.y + 4)
                
            } else if algorithm == "Breadth-first" {
                bfsButton.texture = SKTexture(imageNamed: "leverUp")
                bfsButton.position = CGPoint(x: bfsButton.position.x, y: bfsButton.position.y + 4)
            }
            
            algorithm = "Dijkstra"
        }
    }
    
    func handleTapOnAStar() {
        
        if algorithm == "A*" {
            algorithm = "Dijkstra"
            
            aStarButton.texture = SKTexture(imageNamed: "leverUp")
            aStarButton.position = CGPoint(x: aStarButton.position.x, y: aStarButton.position.y + 4)
            
            dButton.texture = SKTexture(imageNamed: "leverDown")
            dButton.position = CGPoint(x: dButton.position.x, y: dButton.position.y - 4)
        } else {
            
            aStarButton.texture = SKTexture(imageNamed: "leverDown")
            aStarButton.position = CGPoint(x: aStarButton.position.x, y: aStarButton.position.y - 4)
            
            if algorithm == "Dijkstra" {
                dButton.texture = SKTexture(imageNamed: "leverUp")
                dButton.position = CGPoint(x: dButton.position.x, y: dButton.position.y + 4)
                
            } else if algorithm == "Breadth-first" {
                bfsButton.texture = SKTexture(imageNamed: "leverUp")
                bfsButton.position = CGPoint(x: bfsButton.position.x, y: bfsButton.position.y + 4)
            }
            
            algorithm = "A*"
        }
        
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
        for column in 0...tileArray.count-1 {
            for row in 0...tileArray[0].count-1 {
                
                if !((row == Int(playerPos.y) && column == Int(playerPos.x)) || (row == Int(targetPos.y) && column == Int(targetPos.x))) {
                    //if it's not the player neither the target
                    if tileArray[column][row].tile.contains(pos) && !movingPlayer && !movingTarget {
                        if !tileArray[column][row].isObstacle {
                            
                            tileArray[column][row].tile.texture = SKTexture(imageNamed: "void")
                            tileArray[column][row].tile.size = CGSize(width: 40, height: 37.4)
                            tileArray[column][row].tile.alpha = 1.0
                            tileArray[column][row].tile.zPosition = 2
                            tileArray[column][row].isObstacle = true
                            
                            animateObstacleAtPos(column: column, row: row)
                            
                            placedObstacles = true
                        }
                    }
                }
                else {
                    if tileArray[column][row].tile.contains(pos) {
                        if (row == Int(playerPos.y) && column == Int(playerPos.x)) {
                            //if it's moving the player
                            
                            movingPlayer = true
                            tileArray[column][row].tile.isHidden = true
                            movedPlayerOrTarget = true
                        }
                        if (row == Int(targetPos.y) && column == Int(targetPos.x)) {
                            //if it's moving the target
                            movingTarget = true
                            tileArray[column][row].tile.isHidden = true
                            movedPlayerOrTarget = true
                        }
                    }
                }
                
            }
        }
    }
    
    func breadthFirst() -> Bool {
        
        //set all the node’s distances to infinity and add them to an unexplored set
        //in this case we use fCost as the distance
        copyTileArrayToUnexploredList()
        
        //Set the starting node’s distance to 0
        let startingNodePos = tileArray[Int(playerPos.x)][Int(playerPos.y)].id
        unexploredList[startingNodePos].fCost = 0
        
        while !alreadyFoundTarget {
            
            //look for the node with the lowest distance, let this be the current node
            unexploredList.sort(by: { $0.fCost > $1.fCost }) //sorts in descendent order
            let currSquare = unexploredList.last!
            let currentSquarePos = CGPoint(x: currSquare.x, y: currSquare.y)
            
            if currSquare.isTarget {
                //achou
                alreadyFoundTarget = true
                targetId = currSquare.id

                return true
            }
            
            //remove it from the unexplored set
            if unexploredList.count > 0 {
                unexploredList.removeLast()
            } else {
                impossiblePath = true
                return false
            }
            
            
            //for each of the nodes adjacent to this node…
            for offsetY in -1...1 {
                for offsetX in -1...1 {
                    let row = Int(currentSquarePos.y) + offsetY
                    let column = Int(currentSquarePos.x) + offsetX
                    
                    if (column < columns && column >= 0) && (row >= 0 && row < rows) {
                        //if it's not out of the screen
                        let nextCandidate = tileArray[column][row]
                        
                        if !(nextCandidate.isPlayer) {
                            //if it isn't itself
                            
                            if !(nextCandidate.isObstacle) {
                                
                                //stores the tile's id to be painted
                                if !paintIdList.contains(nextCandidate.id){
                                    paintIdList.append(nextCandidate.id)
                                }
                                
                                //calculate a potential new distance
                                //current node’s distance plus the distance to the adjacent node you are at
                                let potentialNewDistance = currSquare.fCost + 1
                                
                                
                                //If the potential distance is less than the adjacent node’s current distance,
                                //then set the adjacent node’s distance to the potential new distance
                                //and set the adjacent node’s parent to the current node
                                if potentialNewDistance < nextCandidate.fCost {
                                    nextCandidate.fCost = potentialNewDistance
                                    nextCandidate.parentId = currSquare.id
                                }
                            }
                        }
                    }
                }
            }
            
        }
        
        return true
    }
    
    func dijkstra() -> Bool {
        
        //set all the node’s distances to infinity and add them to an unexplored set
        //in this case we use fCost as the distance
        copyTileArrayToUnexploredList()
        
        //Set the starting node’s distance to 0
        let startingNodePos = tileArray[Int(playerPos.x)][Int(playerPos.y)].id
        unexploredList[startingNodePos].fCost = 0
        
        while !alreadyFoundTarget {
            
            //look for the node with the lowest distance, let this be the current node
            unexploredList.sort(by: { $0.fCost > $1.fCost }) //sorts in descendent order
            let currSquare = unexploredList.last!
            let currentSquarePos = CGPoint(x: currSquare.x, y: currSquare.y)
            
            if currSquare.isTarget {
                //achou
                alreadyFoundTarget = true
                targetId = currSquare.id
                return true
            }
            
            //remove it from the unexplored set
            if unexploredList.count > 0 {
                unexploredList.removeLast()
            } else {
                impossiblePath = true
                return false
            }
            
            
            //for each of the nodes adjacent to this node…
            for offsetY in -1...1 {
                for offsetX in -1...1 {
                    let row = Int(currentSquarePos.y) + offsetY
                    let column = Int(currentSquarePos.x) + offsetX
                    
                    if (column < columns && column >= 0) && (row >= 0 && row < rows) {
                        //if it's not out of the screen
                        let nextCandidate = tileArray[column][row]
                        
                        if !(nextCandidate.isPlayer) {
                            //if it isn't itself
                            
                            if !(nextCandidate.isObstacle) {
                                
                                //stores the tile's id to be painted
                                if !paintIdList.contains(nextCandidate.id){
                                    paintIdList.append(nextCandidate.id)
                                }
                                
                                //calculate a potential new distance
                                //current node’s distance plus the distance to the adjacent node you are at
                                let potentialNewDistance = offsetX == 0 || offsetY == 0
                                    ? currSquare.fCost + 1
                                    : currSquare.fCost + 1.5
                                
                                //If the potential distance is less than the adjacent node’s current distance,
                                //then set the adjacent node’s distance to the potential new distance
                                //and set the adjacent node’s parent to the current node
                                
                                if potentialNewDistance < nextCandidate.fCost {
                                    nextCandidate.fCost = potentialNewDistance
                                    nextCandidate.parentId = currSquare.id
                                }
                            }
                        }
                    }
                }
            }
            
        }
        
        return true
        
    }
    
    func aStar() -> Bool {
        
        openList.append(tileArray[Int(playerPos.x)][Int(playerPos.y)])
        tileArray[Int(playerPos.x)][Int(playerPos.y)].isOnOpenList = true
        
        while !alreadyFoundTarget {
            
            //Looks for the lowest F cost square on the open list
            var lowestCost = 9999.0
            
            for (index, candidate) in openList.enumerated() {
                if candidate.fCost < lowestCost && candidate.alreadyVisitedNode == false {
                    lowestCost = candidate.fCost
                    lowestCostId = candidate.id
                    lowestCostIndex = index
                }
            }
            
            //lowestCostIndex is the "current square"
            let currSquare = openList[lowestCostIndex]
            let currentSquarePos = CGPoint(x: currSquare.x, y: currSquare.y)
            
            //Switch it to the closed list
            tileArray[Int(currentSquarePos.x)][Int(currentSquarePos.y)].alreadyVisitedNode = true
            closedList.append(currSquare)
            
            openList.remove(at: lowestCostIndex)
            
            if currSquare.isTarget {
                //found target
                
                targetId = currSquare.id
                alreadyFoundTarget = true
                
                return true
            }
            
            //the current square on the tileArray is the tile with currentSquarePos
            //for each of the 8 squares adjacent to this current square...
            for offsetY in -1...1 {
                for offsetX in -1...1 {
                    iterations += 1
                    
                    let row = Int(currentSquarePos.y) + offsetY
                    let column = Int(currentSquarePos.x) + offsetX
                    
                    if (column < columns && column >= 0) && (row >= 0 && row < rows) {
                        let nextCandidate = tileArray[column][row]
                        //if it's not out of the screen
                        if !(nextCandidate.isPlayer) {
                            //if it isn't itself
                            if !(nextCandidate.isObstacle) && !(nextCandidate.alreadyVisitedNode) {
                                //if it's not an obstacle and has not been visited yet
                                //if it isn’t on the open list, add it to the open list
                                if !nextCandidate.isOnOpenList {
                                   
                                    openList.append(nextCandidate)
                                    nextCandidate.isOnOpenList = true
                                    
                                    //stores the tile's id to be painted
                                    if !paintIdList.contains(nextCandidate.id){
                                        paintIdList.append(nextCandidate.id)
                                    }
                                    
                                    
                                    //make the current square the parent of this square
                                    nextCandidate.parentId = currSquare.id
                                    
                                    //record the F, G, and H costs of the square
                                    nextCandidate.hCost = euclideanDistance(x1: Double(column), y1: Double(row), x2: Double(targetPos.x), y2: Double(targetPos.y))
                                    
                                    if offsetX == 0 || offsetY == 0 {
                                        //if the tile is horizontal or vertical
                                        nextCandidate.gCost = currSquare.gCost + 1
                                    } else {
                                        //if it is a diagonal
                                        nextCandidate.gCost = currSquare.gCost + 1.5
                                    }
                                    
                                    
                                    nextCandidate.fCost = nextCandidate.gCost + nextCandidate.hCost
                                    
                                } else {
                                    //check to see if this path to that square is better
                                    
                                    let potentialGCost = offsetX == 0 || offsetY == 0
                                        ? currSquare.gCost + 1
                                        : currSquare.gCost + 1.5
                                    
                                    if nextCandidate.gCost > potentialGCost {
                                        //change the parent of the square to the current square
                                        nextCandidate.parentId = currSquare.id
                                        //recalculate the G and F scores of the square
                                        nextCandidate.gCost = potentialGCost
                                        nextCandidate.fCost = nextCandidate.gCost + nextCandidate.hCost
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
            
            if iterations >= mapSize {
                impossiblePath = true
                return false
            }
            
        }
        return true
    }
    
    func copyTileArrayToUnexploredList() {
        for column in 0...tileArray.count-1 {
            for row in 0...tileArray[0].count-1 {
                unexploredList.append(tileArray[column][row])
            }
        }
    }
    
    func createDrawPathList() {
        let targetPos = idToPos(id: targetId)
        var drawingTile = tileArray[targetPos.x][targetPos.y]
        
        while !drawingTile.isPlayer {
            if !drawingTile.isTarget {
                pathIdList.append(drawingTile.id)
            }
            
            let nextPos = idToPos(id: drawingTile.parentId)
            drawingTile = tileArray[nextPos.x][nextPos.y]
        }
    }
    
    
    func idToPos(id: Int) -> Pos {
        return Pos(y: id % rows, x: Int(id/rows))
    }
    
    func posToId(pos: Pos) -> Int {
        return (rows*pos.x + pos.y)
    }
    
    
    func touchUp(atPoint pos : CGPoint) {
        if movingPlayer {
            movingPlayer = false
            for column in 0...tileArray.count-1 {
                for row in 0...tileArray[0].count-1 {
                    if tileArray[column][row].tile.contains(pos) {
                        
                        tileArray[Int(playerPos.x)][Int(playerPos.y)].isPlayer = false
                        tileArray[Int(playerPos.x)][Int(playerPos.y)].tile.texture = SKTexture(imageNamed: "nebula")
                        tileArray[Int(playerPos.x)][Int(playerPos.y)].tile.size = CGSize(width: nodeSize, height: nodeSize)
                        tileArray[Int(playerPos.x)][Int(playerPos.y)].tile.alpha = nodeInitialOpacity
                        tileArray[Int(playerPos.x)][Int(playerPos.y)].tile.isHidden = false
                        
                        tileArray[column][row].tile.isHidden = false
                        tileArray[column][row].tile.texture  = SKTexture(imageNamed: "planet")
                        tileArray[column][row].tile.size = CGSize(width: 45, height: 36.8)
                        tileArray[column][row].tile.alpha = 1.0
                        tileArray[column][row].isPlayer = true
                        playerPos.x = CGFloat(column)
                        playerPos.y = CGFloat(row)
                        playerId = posToId(pos: Pos(column, row))
                        
                        movablePlayer.position = playerPos
                        
                        return
                    }
                    
                }
            }
            //se nao entrou no for quer dizer que ta pra fora da tela
            tileArray[Int(playerPos.x)][Int(playerPos.y)].tile.isHidden = false
        }
        
        if movingTarget {
            movingTarget = false
            for column in 0...tileArray.count-1 {
                for row in 0...tileArray[0].count-1 {
                    if tileArray[column][row].tile.contains(pos) {
                        
                        tileArray[Int(targetPos.x)][Int(targetPos.y)].isTarget = false
                        tileArray[Int(targetPos.x)][Int(targetPos.y)].tile.removeAllActions()
                        tileArray[Int(targetPos.x)][Int(targetPos.y)].tile.texture = SKTexture(imageNamed: "nebula")
                        tileArray[Int(targetPos.x)][Int(targetPos.y)].tile.size = CGSize(width: nodeSize, height: nodeSize)
                        tileArray[Int(targetPos.x)][Int(targetPos.y)].tile.alpha = nodeInitialOpacity
                        tileArray[Int(targetPos.x)][Int(targetPos.y)].tile.isHidden = false
                        
                        tileArray[column][row].tile.isHidden = false
                        tileArray[column][row].tile.texture  = SKTexture(imageNamed: "star")
                        tileArray[column][row].tile.size = CGSize(width: 60, height: 42.4)
                        tileArray[column][row].tile.alpha = 1.0
                        tileArray[column][row].isTarget = true
                        animateTarget(column: column, row: row)
                        targetPos.x = CGFloat(column)
                        targetPos.y = CGFloat(row)
                        targetId = posToId(pos: Pos(column, row))
                        
                        movableStar.position = targetPos
                        
                        return
                    }
                    
                }
            }
            tileArray[Int(targetPos.x)][Int(targetPos.y)].tile.isHidden = false
            
        }
        
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
        
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            for column in 0...tileArray.count-1 {
                for row in 0...tileArray[0].count-1 {
                    
                    if tileArray[column][row].tile.contains(location) && tileArray[column][row].isPlayer {
                    
                        movablePlayer.isHidden = false
                        movableNode = movablePlayer
                        
                        movableNode!.position = location
                        
                    }
                    
                    if tileArray[column][row].tile.contains(location) && tileArray[column][row].isTarget {
                    
                        movableStar.isHidden = false
                        movableNode = movableStar
                        
                        movableNode!.position = location
                        
                    }
                }
            }
            
            
        }
        
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
        if let touch = touches.first, movableNode != nil {
            movableNode!.position = touch.location(in: self)
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
        
        if let touch = touches.first, movableNode != nil {
            movableNode!.position = touch.location(in: self)
            movableNode = nil
            movablePlayer.isHidden = true
            movableStar.isHidden = true
        }
        
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
        
        if let touch = touches.first {
            movableNode = nil
        }
        
    }
    
    override public func update(_ currentTime: TimeInterval) {
        
    }
    
    func disableUserInteraction(shouldDisable: Bool) {
        self.view?.isUserInteractionEnabled = !shouldDisable
    }
    
    @objc func paintPath() {
        
        let id = pathIdList.first
        let pos = idToPos(id: id ?? 0)
        
        tileArray[pos.x][pos.y].tile.alpha = 1.0
        tileArray[pos.x][pos.y].tile.texture = SKTexture(imageNamed: "visitedNode2")
        tileArray[pos.x][pos.y].tile.size =  CGSize(width: 55, height: 55)
        
        if pathIdList.count > 1 {
            pathIdList.removeFirst()
        } else {
            tileArray[Int(playerPos.x)][Int(playerPos.y)].tile.texture = SKTexture(imageNamed: "planet")
            tileArray[Int(playerPos.x)][Int(playerPos.y)].tile.zPosition = 3
            
            disableUserInteraction(shouldDisable: false)
            
            if timer != nil {
                timer!.invalidate()
                timer = nil
            }
        }
    }
    
    @objc func paintVisitedTile() {
        
        let id = paintIdList.first
        let pos = idToPos(id: id ?? 0)
        
        let desappear = SKAction.fadeAlpha(to: 0.0, duration: drawingSpeed)
        
        if !(pos.x == Int(targetPos.x) && pos.y == Int(targetPos.y)) {
            tileArray[pos.x][pos.y].tile.run(desappear)
        }
        
        if paintIdList.count > 1 {
            paintIdList.removeFirst()
        } else {
            if timer != nil {
                timer!.invalidate()
                timer = nil
            }
            
            timer = Timer.scheduledTimer(timeInterval: drawingSpeed, target: self, selector: #selector(GameScene.paintPath), userInfo: nil, repeats: true)
        }
        
    }
    
    func playMusic() {
        
//        do {
//            music = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:
//                Bundle.main.path(forResource: "Bongo_Madness", ofType: "mp3")!))
//            music.prepareToPlay()
//            music.numberOfLoops = -1
//            let audioSession = AVAudioSession.sharedInstance()
//            do {
//                try audioSession.setCategory(AVAudioSession.Category.playback)
//            }
//            catch {
//            }
//        }
//        catch {
//            print("Error: could not play theme song")
//        }
//        music.play()
    }
    
}
