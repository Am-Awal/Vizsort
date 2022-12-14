//
//  GameScene.swift
//  Vizsort
//
//  Created by Awal Amadou on 11/12/22.
//

import SpriteKit
import GameplayKit


// TODO: landscape mode

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var complexityLabel : SKLabelNode?
    private var tenLabel : SKLabelNode?
    private var twentyFiveLabel : SKLabelNode?
    private var fiftyLabel : SKLabelNode?
    private var hundredLabel : SKLabelNode?
    private var swapsLabel : SKLabelNode?
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
        let labelNode = SKLabelNode(text: "Insertion Sort")
        labelNode.position = CGPoint(x: 0, y: self.size.height * 0.4)
        labelNode.name = "sortLabel"
        labelNode.fontSize = CGFloat(35.0)
        labelNode.fontColor = UIColor.black
        labelNode.fontName = "Avenir Next Heavy"
        
        var background = SKSpriteNode(color: UIColor.blue, size: CGSize(width: CGFloat(self.size.width), height:CGFloat(self.size.height)))
        background.position = labelNode.position
        background.zPosition = -1
        labelNode.addChild(background)

        self.label = labelNode

        if let label = self.label {
            label.run(SKAction.fadeIn(withDuration: 0.5))
//            label.name = "helloNode"
            self.addChild(label)
        }
        
        let complexityNode = SKLabelNode(text: "Complexity: O(n^2) time, O(1) space, (n^2)/4 avg.")
        complexityNode.position = CGPoint(x: 0, y: self.size.height * 0.375)
        complexityNode.name = "sortLabel"
        complexityNode.fontSize = CGFloat(25.0)
        complexityNode.fontColor = UIColor.black
        complexityNode.fontName = "Helvetica"
        
        self.complexityLabel = complexityNode

        if let complexityLabel = self.complexityLabel {
            complexityLabel.run(SKAction.fadeIn(withDuration: 0.5))
//            label.name = "helloNode"
            self.addChild(complexityLabel)
        }
        
        let tenNode = SKLabelNode(text: "10")
        tenNode.position = CGPoint(x: -self.size.width * 0.325, y: self.size.height * 0.335)
        tenNode.name = "tenNode"
        tenNode.fontSize = CGFloat(30.0)
        tenNode.fontColor = UIColor.systemOrange
        tenNode.fontName = "Avenir Next Heavy"
        self.tenLabel = tenNode
        if let tenLabel = self.tenLabel {
            tenLabel.run(SKAction.fadeIn(withDuration: 0.5))
//            tenLabel.name = "tenNode"
            self.addChild(tenLabel)
        }
        
        let twentyFiveNode = SKLabelNode(text: "25")
        twentyFiveNode.position = CGPoint(x: -self.size.width * 0.125, y: self.size.height * 0.335)
        twentyFiveNode.name = "twentyFiveNode"
        twentyFiveNode.fontSize = CGFloat(30.0)
        twentyFiveNode.fontName = "Avenir Next Heavy"
        twentyFiveNode.fontColor = UIColor.systemOrange
        self.twentyFiveLabel = twentyFiveNode
        if let twentyFiveLabel = self.twentyFiveLabel {
            twentyFiveLabel.run(SKAction.fadeIn(withDuration: 0.5))
//            tenLabel.name = "tenNode"
            self.addChild(twentyFiveLabel)
        }
        
        
        
        let fiftyNode = SKLabelNode(text: "50")
        fiftyNode.position = CGPoint(x: self.size.width * 0.125, y: self.size.height * 0.335)
        fiftyNode.name = "fiftyNode"
        fiftyNode.fontSize = CGFloat(30.0)
        fiftyNode.fontColor = UIColor.systemOrange
        fiftyNode.fontName = "Avenir Next Heavy"
        self.fiftyLabel = fiftyNode
        if let fiftyLabel = self.fiftyLabel {
            fiftyLabel.run(SKAction.fadeIn(withDuration: 0.5))
//            tenLabel.name = "tenNode"
            self.addChild(fiftyLabel)
        }
        
        let hundredNode = SKLabelNode(text: "100")
        hundredNode.position = CGPoint(x: self.size.width * 0.325, y: self.size.height * 0.335)
        hundredNode.name = "hundredNode"
        hundredNode.fontSize = CGFloat(30.0)
        hundredNode.fontColor = UIColor.systemOrange
        hundredNode.fontName = "Avenir Next Heavy"
        self.hundredLabel = hundredNode
        if let hundredLabel = self.hundredLabel {
            hundredLabel.run(SKAction.fadeIn(withDuration: 0.5))
//            tenLabel.name = "tenNode"
            self.addChild(hundredLabel)
        }
        
        barHeight = Int(0.7 * (self.size.height))
        insertionSort()
        
        let swapsNode = SKLabelNode(text: "Swaps:")
        swapsNode.position = CGPoint(x: -((0.5) * self.size.width) * 0, y: -(0.425 * self.size.height))
        swapsNode.name = "swapsNode"
        swapsNode.fontSize = CGFloat(30.0)
        swapsNode.fontColor = UIColor.systemOrange
        swapsNode.fontName = "Avenir Next Heavy"
        self.swapsLabel = swapsNode
        if let swapsLabel = self.swapsLabel {
            swapsLabel.run(SKAction.fadeIn(withDuration: 0.5))
            self.addChild(swapsLabel)
        }
        
        self.backgroundColor = UIColor.black
   
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
    
    func drawButtons(toPoint pos : CGPoint) {
        if let i = self.complexityLabel?.copy() as! SKLabelNode? {
            self.addChild(i)
        }
        
        if let j = self.label?.copy() as! SKLabelNode? {
            self.addChild(j)
        }
        
        if let k = self.tenLabel?.copy() as! SKLabelNode? {
            self.addChild(k)
        }
        
        if let l = self.twentyFiveLabel?.copy() as! SKLabelNode? {
            self.addChild(l)
        }
        
        if let m = self.fiftyLabel?.copy() as! SKLabelNode? {
            self.addChild(m)
        }
        
        if let n = self.hundredLabel?.copy() as! SKLabelNode? {
            self.addChild(n)
        }
        
        
    }
    
    func drawBars(pt: CGPoint) {
        
        if pt.x >= 0.0 && pt.y < (self.size.height * 0.3){
            curr += 1
            if curr >= omega.count {
                curr = omega.count - 1
            }
            sampleToAdd = omega[curr]
        } else {
            curr -= 1
            if curr < 0 {
                curr = 0
            }
            sampleToAdd = omega[curr]
        }
        
        if let s = self.swapsLabel?.copy() as! SKLabelNode? {
            s.text = "swaps: \(curr)"
            s.position = CGPoint(x: -((0.5-0.1) * self.size.width) * 0, y: -(0.425 * self.size.height))
            self.addChild(s)
        }
        
        let n = generateBarPoints(heights: sampleToAdd, width: barWidth, mxHt: barHeight)
        //            m.position = pos
        n.position = CGPoint(x: -((0.5-0.1) * self.size.width), y: -(0.4 * self.size.height))
        n.strokeColor = SKColor.systemOrange
        n.lineWidth = 2.5
        n.fillColor = UIColor.blue
        
        self.addChild(n)
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
        barWidth = Int(0.8 * (self.size.width / CGFloat( maxNumber)))
        sample = [Int](1...maxNumber).shuffled()
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
    func redrawBars(atPoint pos : CGPoint) {
        self.removeAllChildren()
        drawButtons(toPoint: pos)
        drawBars(pt: pos)
        
    }
    func touchDown(atPoint pos : CGPoint) {
        //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
        //            n.position = pos
        //            n.strokeColor = SKColor.green
        //            self.addChild(n)
        //        }
        
        let touchedNode = atPoint(pos)
        
        if touchedNode.name == "tenNode" {
            
            self.maxNumber = 10
            insertionSort()
            redrawBars(atPoint: pos)
            
        } else if touchedNode.name == "twentyFiveNode" {
            
            self.maxNumber = 25
            insertionSort()
            redrawBars(atPoint: pos)
        } else if touchedNode.name == "fiftyNode" {
            
            self.maxNumber = 50
            insertionSort()
            redrawBars(atPoint: pos)
            
        } else if touchedNode.name == "hundredNode" {
            
            self.maxNumber = 100
            insertionSort()
            redrawBars(atPoint: pos)
            
        }
        
        if pos.y < (self.size.height * 0.3) {
            redrawBars(atPoint: pos)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
        //            n.position = pos
        //            n.strokeColor = SKColor.blue
        //            self.addChild(n)
        //        }
        if pos.y < 0 {
            redrawBars(atPoint: pos)
        }
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
