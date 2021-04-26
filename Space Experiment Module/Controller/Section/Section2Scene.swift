//
//  Section2Scene.swift
//  Space Experiment Module
//
//  Created by 曹亚索 on 2020/12/18.
//
//MARK:Section 2
import SpriteKit

class Section2Scene: SKScene {
    
    var contentCreated = false
    var background1 : SKSpriteNode!
    var background2 : SKSpriteNode!
    var deltaTime : TimeInterval = 0
    var lastFrameTime : TimeInterval = 0
    
    override init(size:CGSize){
        
        background1 = SKSpriteNode(texture: SKTexture(imageNamed: "gameScene2"),size: CGSize(width: size.width, height: size.height))
        background1.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        background2 = (background1.copy() as! SKSpriteNode)
        background2.position = CGPoint(x: background1.position.x + size.width, y: background1.position.y)
        super.init(size: size)
        addChild(background1)
        addChild(background2)
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        if self.contentCreated == false{
            self.createSceneContents()
            contentCreated = true
            
        }
    }
    func createSceneContents(){
        self.backgroundColor = SKColor.black
        self.contentCreated = true
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        if lastFrameTime == 0{
            lastFrameTime = currentTime
        }
        deltaTime = currentTime - lastFrameTime
        lastFrameTime = currentTime
        move(sprite1: background1, sprite2: background2, movingSpeed: 200)
    }
    
    func move(sprite1:SKSpriteNode,sprite2:SKSpriteNode,movingSpeed:CGFloat)->Void{
        var pointX1 : CGFloat = background1.position.x
        var pointX2 : CGFloat = background2.position.x
        //建立两个点之间的联系
        if pointX1 < pointX2{
            pointX1 -= (movingSpeed * CGFloat(deltaTime))
            pointX2 = pointX1 + background1.size.width
            if pointX1 <=  -background1.size.width / 2{
                pointX1 = pointX2 + background1.size.width
            }
        }else{
            pointX2 -= movingSpeed * CGFloat(deltaTime)
            pointX1 = pointX2 + background1.size.width
            if pointX2 <= -background1.size.width / 2{
                pointX2 = pointX1 + background1.size.width          
            }
        }
        sprite1.position.x = pointX1
        sprite2.position.x = pointX2
    }
    
}
