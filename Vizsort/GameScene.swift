//
//  GameScene.swift
//  Vizsort
//
//  Created by Awal Amadou on 11/12/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var curr = 0
    private var omega : [[Int]] = []
    private var sample : [Int] = []
    private var sampleToAdd : [Int] = []
    private var maxNumber: Int = 25
    private var nSwaps = 0
    private var configIndex = 0
    private var bars : SKShapeNode?
    private var barWidth : Int = 1
    private var barHeight: Int = 1
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later

//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        let labelNode = SKLabelNode(text: "New Sample Insertion Sort")
        labelNode.position = CGPoint(x: 0, y: self.size.height * 0.4)
        labelNode.name = "helloNode"
        labelNode.fontSize = CGFloat(30.0)
        labelNode.fontName = "Avenir Next Heavy"
        self.label = labelNode

        if let label = self.label {
            label.run(SKAction.fadeIn(withDuration: 0.5))
//            label.name = "helloNode"
            self.addChild(label)
        }
                
        
        barWidth = Int(0.8 * (self.size.width / CGFloat( maxNumber)))
        barHeight = Int(0.7 * (self.size.height))
        sample = [Int](1...maxNumber).shuffled()
        
        insertionSort()
   
    }
    
    func generateBarPoints(heights: [Int], width: Int, mxHt: Int) -> SKShapeNode {
        var points = [CGPoint(x: 0, y: 0)]
                
        let top: Int = heights.max()!
        
        for i in 0...(heights.count-1) {
            let ht = Int( mxHt * (top - heights[i]) / top)
            
            let up = CGPoint(x: i * width, y: ht)
            let right = CGPoint(x: (1 + i) * width, y: ht)
            let down = CGPoint(x: (1 + i) * width, y: 0)
            
            points.append(up)
            points.append(right)
            points.append(down)
        }
        let shape = SKShapeNode(points: &points, count: points.count)
        return shape
    }
    
    func drawBars(toPoint pos : CGPoint) {
        if let m = self.label?.copy() as! SKLabelNode? {
            m.position = CGPoint(x: 0, y: self.size.height * 0.4)
            m.name = "helloNode"
            self.addChild(m)
        }
        
        let touchedNode = atPoint(pos)
        if touchedNode.name == "helloNode" {
            insertionSort()
        }
        
        if curr < omega.count {
            sampleToAdd = omega[curr]
            curr += 1
        }
        else {
            curr = 0
        }
        let m = generateBarPoints(heights: sampleToAdd, width: barWidth, mxHt: barHeight)
        //            m.position = pos
        m.position = CGPoint(x: -((0.5-0.1) * self.size.width), y: -(0.4 * self.size.height))
        m.strokeColor = SKColor.systemOrange
        m.lineWidth = 2.5
        m.fillColor = UIColor.blue
        self.addChild(m)
        
    }
    
    func swap(a: Int, b: Int) {
        //        Main swap logic
        let tmp = sample[a]
        sample[a] = sample[b]
        sample[b] = tmp
        //        end swap logic
        

        omega.append(sample.reversed())
    }
    
    func insertionSort() {
        nSwaps = 0
//        setUpVals()
        var maxNum = maxNumber
        maxNum = maxNum - 1
        omega = []
        sample.shuffle()
        omega.append(sample.reversed())
        curr = 0
        
        // bounds check
        for i in 1...maxNum {
            
            let j = i
            for k in Array(1...j).reversed() {
                if sample[k] < sample[k-1]  {
                    swap(a: k, b: k-1)
                    
                } else {break}
            }
        }
    }
    
    
    
    
    
    // Touch handling
    //
    //
    
    func touchDown(atPoint pos : CGPoint) {
        //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
        //            n.position = pos
        //            n.strokeColor = SKColor.green
        //            self.addChild(n)
        //        }
        self.removeAllChildren()
        drawBars(toPoint: pos)

    }
    
    func touchMoved(toPoint pos : CGPoint) {
        //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
        //            n.position = pos
        //            n.strokeColor = SKColor.blue
        //            self.addChild(n)
        //        }
        self.removeAllChildren()
        drawBars(toPoint: pos)
    }
    
    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//
//        }
        
        
        
        for t in touches { self.touchDown(atPoint: t.location(in: self))}
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
        
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

class TouchSpriteNode: SKSpriteNode {
    override var isUserInteractionEnabled: Bool {
        set {
            // ignore
        }
        get {
            return true
        }
    }
         
    // For macOS replace this method with `mouseDown(with:)`
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // User has touched this node
        self.run(SKAction.fadeOut(withDuration: 0.5))
        self.removeFromParent()

    }
}

extension SKColor {
    static var random: SKColor {
        return SKColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
