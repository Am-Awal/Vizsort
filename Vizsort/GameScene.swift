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
//
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
                
        
        barWidth = Int(0.75 * (self.size.width / CGFloat( maxNumber)))
        barHeight = Int(0.75 * (self.size.height))
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
    
    
    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
        
//        if let m = self.block?.copy() as! SKSpriteNode? {
//            m.position = pos
//            self.addChild(m)
//        }
//        self.removeAllChildren()
//        if let m = self.bars?.copy() as! SKShapeNode? {
//            m.position = pos
//            m.position = CGPoint(x: -((0.5-0.125) * self.size.width), y: -(0.4 * self.size.height))
//            m.strokeColor = SKColor.green
//            self.addChild(m)
//        }
        
//
//        if curr < omega.count {
//            sampleToAdd = omega[curr]
//            curr += 1
//        }
//        else {
//            curr = 0
//        }
//
        self.removeAllChildren()
        
        if curr < omega.count {
            sampleToAdd = omega[curr]
            curr += 1
        }
        else {
            insertionSort()
            curr = 0
        }
        let m = generateBarPoints(heights: sampleToAdd, width: barWidth, mxHt: barHeight)
//            m.position = pos
            m.position = CGPoint(x: -((0.5-0.125) * self.size.width), y: -(0.4 * self.size.height))
            m.strokeColor = SKColor.systemYellow
            m.lineWidth = 10.5
            m.name = "m"
            self.addChild(m)
//        let new = self.childNode(withName: "m")
//        new?.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                    SKAction.fadeOut(withDuration: 0.5),
//                                    SKAction.removeFromParent()]))
    }
    
    func swap(a: Int, b: Int) {
        //        Main swap logic
        let tmp = sample[a]
        sample[a] = sample[b]
        sample[b] = tmp
        //        end swap logic
        

        omega.append(sample.reversed())
//        usleep(1000000)
                
        
    }
    
    func insertionSort() {
        nSwaps = 0
//        setUpVals()
        var maxNum = maxNumber
        maxNum = maxNum - 1
        omega = []
        sample.shuffle()
        omega.append(sample.reversed())
        
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
    
    
    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
        self.removeAllChildren()
        
        if curr < omega.count {
            sampleToAdd = omega[curr]
            curr += 1
        }
        else {
            curr = 0
        }
        let m = generateBarPoints(heights: sampleToAdd, width: barWidth, mxHt: barHeight)
//            m.position = pos
            m.position = CGPoint(x: -((0.5-0.125) * self.size.width), y: -(0.4 * self.size.height))
            m.strokeColor = SKColor.systemYellow
            m.lineWidth = 10.5
            self.addChild(m)
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
           
        }
        
        
        
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
