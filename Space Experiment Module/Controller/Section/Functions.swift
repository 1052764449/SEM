//
//  Functions.swift
//  Space Experiment Module
//
//  Created by 曹亚索 on 2020/12/19.
//

import SpriteKit
//MARK:精灵初始化
func setupSprite(sourceName:String,width:CGFloat,height:CGFloat,positionX:CGFloat,positionY:CGFloat,sender:SKNode,UIntNum:UInt32)->SKSpriteNode{
    var sourceId = sourceName
    if sourceName == ""{
        sourceId = characterIdArray[currentCharacter]
    }
    let sprite = SKSpriteNode(texture: SKTexture(imageNamed: sourceId), size: CGSize(width: width, height: height))
    sprite.position = CGPoint(x: positionX, y: positionY)
    sprite.physicsBody = SKPhysicsBody(circleOfRadius: width / 2)
    let categoryBitMask : UInt32 = UIntNum
    sprite.physicsBody?.categoryBitMask = categoryBitMask
    sprite.physicsBody?.contactTestBitMask = 2
    sender.addChild(sprite)
    return sprite
}

//MARK:精灵移动脚本
func spriteMove(sprite:SKSpriteNode,speed:CGFloat,deltaTime:TimeInterval){
    var pointX = sprite.position.x
    var pointY = sprite.position.y
    pointX -= speed * CGFloat(deltaTime)
    //出屏幕时
    if pointX <= -sprite.size.width / 2{
        let a = Int.random(in: 1...2)
        pointX = UIScreen.main.bounds.width + sprite.size.width + CGFloat(Int.random(in: 0...1000))
        if a == 1{
            pointY = UIScreen.main.bounds.midY + sprite.size.height / 2
        }else{
            pointY = UIScreen.main.bounds.midY - sprite.size.height / 2
        }
    }
        sprite.position = CGPoint(x: pointX, y: pointY)
}



