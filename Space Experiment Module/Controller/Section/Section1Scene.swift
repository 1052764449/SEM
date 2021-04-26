//
//  Section1Scene.swift
//  Space Experiment Module
//
//  Created by 曹亚索 on 2020/12/18.
//
//MARK:Section 1

import SpriteKit
class Section1Scene: SKScene ,SKPhysicsContactDelegate{
    var viewcontroller : UIViewController?

    var contentCreated = false
    var background1 : SKSpriteNode!
    var background2 : SKSpriteNode!
    var deltaTime : TimeInterval = 0
    var lastFrameTime : TimeInterval = 0
    var plantSprite : SKSpriteNode!
    var insect : SKSpriteNode!
    var sun : SKSpriteNode!
    var plantposition : Int = 1
    var initiateTime : TimeInterval!
    var score : Int = 0
    var scoreLabel : SKLabelNode!
    var speedLabel : SKLabelNode!
    var back : UIButton!
    var gamespeed : Double = 1
    var sudu : Double! = 1
    var restart : Bool!
    //阶段加速
    var speed1 = false
    var speed2 = false
    var speed3 = false
    var speed4 = false
    //上航道
    let sideup = UIScreen.main.bounds.midY + 30
    //下航道
    let sidedown = UIScreen.main.bounds.midY - 30
    
    //MARK:didMove
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        if self.contentCreated == false{
            self.createSceneContents()
            contentCreated = true
            //加载背景
            setupBackGround()
            //加载精灵
            setupCharacters()
            //set分数
            setupLabel()
            currentScore = 0
        }
    }
    
    func createSceneContents(){
        self.backgroundColor = SKColor.black
        self.contentCreated = true
    }
    
    func setupBackGround(){
        background1 = SKSpriteNode(texture: SKTexture(imageNamed: "gameScene1"),size: CGSize(width: size.width, height: size.height))
        background1.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background2 = (background1.copy() as! SKSpriteNode)
        background2.position = CGPoint(x: background1.position.x + size.width, y: background1.position.y)
        self.addChild(background1)
        self.addChild(background2)
    }
    
    //MARK:scoreLabel
    func setupLabel(){
        
        scoreLabel = SKLabelNode(fontNamed:"MarkerFelt-Wide")
        scoreLabel.fontColor = UIColor.black
        scoreLabel.position = CGPoint(x: self.frame.midX, y: 3 * self.frame.size.height / 4)
        scoreLabel.zPosition = 100
        scoreLabel.text = "\(score)"
        self.addChild(scoreLabel)
    }
    
    //MARK:speed rise label
    func speedUpLabel(){
        speedLabel = SKLabelNode(fontNamed:"MarkerFelt-Wide")
        speedLabel.fontColor = UIColor.red
        speedLabel.position = CGPoint(x: UIScreen.main.bounds.maxX+speedLabel.frame.maxX, y: 5 * self.frame.size.height / 8)
        speedLabel.zPosition = 100
        speedLabel.text = "游戏加速。。"
        self.addChild(speedLabel)
        let moveGroundSprite = SKAction.moveBy(x: -(UIScreen.main.bounds.maxX+speedLabel.frame.maxX), y: 0, duration: TimeInterval(3))
        speedLabel.run(moveGroundSprite)
    }
    
    //MARK:添加精灵
    func setupCharacters(){
        //plant
        plantSprite = setupSprite(sourceName: "", width: 20, height: 20, positionX: UIScreen.main.bounds.width / 10, positionY: sideup, sender: self,UIntNum: 0x1)
        plantSprite.physicsBody?.isDynamic = false
        //insect
        insect = setupSprite(sourceName: "chong1", width: 50, height: 50, positionX: UIScreen.main.bounds.width + 100, positionY: sideup, sender: self,UIntNum: 0x2)
        //sun
        sun = setupSprite(sourceName: "sun1", width: 40, height: 40, positionX: UIScreen.main.bounds.width + 200, positionY: sideup, sender: self,UIntNum: 0x3)
    }
    
    //MARK:游戏帧率刷新
    var calTime : TimeInterval = 0
    override func update(_ currentTime: TimeInterval) {
        if lastFrameTime == 0{
            calTime = currentTime
            lastFrameTime = currentTime
            initiateTime = currentTime
        }
        
        //利用游戏计时器，游戏加速
        let timeMark = currentTime - calTime
        if timeMark <= 10{
            gamespeed = 1
        }else if timeMark > 10 && timeMark <= 20 {
             if speed1 == false{
                speed1 = true
                speedUp(speedUpTo: 1.5)
            }
        }else if timeMark > 20 && timeMark <= 30{
            if speed2 == false{
                speed2 = true
                speedUp(speedUpTo: 2)
            }
            
        }else if timeMark > 30 && timeMark <= 40{
            if speed3 == false{
                speed3 = true
                speedUp(speedUpTo: 2.5)
            }
        }else if timeMark > 40{
            if speed4 == false{
                speed4 = true
                speedUp(speedUpTo: 3)
            }
        }
        
        deltaTime = currentTime - lastFrameTime
        lastFrameTime = currentTime
        //
        backgroundMove(sprite1: background1, sprite2: background2, movingSpeed: 200*CGFloat(sudu))
        //insect move
        spriteMove(sprite: insect, speed: CGFloat(400*gamespeed*sudu),deltaTime: deltaTime)
        //sun move
        spriteMove(sprite: sun, speed: CGFloat(400*gamespeed*sudu), deltaTime: deltaTime)
    }
    
    
    //MARK:用户交互
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if sudu > 0{
            let plantPosition1 = CGPoint(x: UIScreen.main.bounds.width / 10, y: sideup)
            let plantPosition2 = CGPoint(x: UIScreen.main.bounds.width / 10, y: sidedown)
            if plantposition == 1{                       //在上面
                plantSprite.position = plantPosition2                    //去下面
                plantposition = 2
            }else{
                plantSprite.position = plantPosition1                    //去上面
                plantposition = 1
            }
        }else{
            reset()
        }
        
    }
    
    
    //MARK:游戏碰撞
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        let c = bodyA.categoryBitMask + bodyB.categoryBitMask
        if c == 3{//植物 撞 虫
            if testmode == true{
                print("test mode")
            }else{
                gameOver()
            }
        }else if c == 4{//植物 撞 太阳
            goal()
        }
    }
    //加分 重置 太阳
    func goal(){
        sun.removeFromParent()
        score += 1
        currentScore = score
        scoreLabel.text = String(score)
        scoreLabel.run(SKAction.sequence([SKAction.scale(to: 1.5, duration:TimeInterval(0.1)), SKAction.scale(to: 1.0, duration:TimeInterval(0.1))]))
        sun = setupSprite(sourceName: "sun1", width: 40, height: 40, positionX: UIScreen.main.bounds.width + 40 + CGFloat(Int.random(in: 0...1000)), positionY: UIScreen.main.bounds.midY + 25, sender: self,UIntNum: 0x3)
    }
    //游戏结束
    func gameOver(){
        assets += score
        UserDefaults.standard.setValue(assets, forKey: "assets")
        sudu = 0
        self.markScore()
        self.alpha = 0.5
        Alert().showimageAlert(imageName: "gameover") { (gameover) in
            self.alpha = 1
        }
    }
    //MARK:重置游戏
    func reset(){
        self.removeAllChildren()
        
        setupBackGround()
        score = 0
        setupLabel()
        setupCharacters()
        plantposition = 1
        lastFrameTime = 0
        
        sudu = 1
    }
    func markScore(){
        if let topscore = UserDefaults.standard.string(forKey: "topscore"){
            if score >= Int(topscore)!{
                UserDefaults.standard.set(score, forKey: "topscore")
            }
        }else{
            UserDefaults.standard.set(score, forKey: "topscore")
        }
    }
    //MARK:背景移动脚本
    func backgroundMove(sprite1:SKSpriteNode,sprite2:SKSpriteNode,movingSpeed:CGFloat)->Void{
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
    
    func exitButton(){
        let exitButton = UIButton(frame: CGRect(x: 20, y: 64, width: 77, height: 48))
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(tap:)))
        exitButton.addGestureRecognizer(tap)
        self.view?.addSubview(exitButton)
    }
    
    @objc func handleTap(tap:UIGestureRecognizer){
        if tap.state == .ended{
        }
    }
    
    func speedUp(speedUpTo:Double){
        var countDownNum = 5
//        //所有怪物移除屏幕
//        insect.removeFromParent()
//        sun.removeFromParent()
        //提示加速
        speedUpLabel()
        //计时3秒
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
            if countDownNum == 0 {
                  // 销毁计时器
                timer.invalidate()
//                //重新载入怪物
//                insect = setupSprite(sourceName: "chong1", width: 50, height: 50, positionX: UIScreen.main.bounds.width + 100, positionY: sideup, sender: self,UIntNum: 0x2)
//                sun = setupSprite(sourceName: "sun1", width: 40, height: 40, positionX: UIScreen.main.bounds.width + 200, positionY: sideup, sender: self,UIntNum: 0x3)
            } else if countDownNum == 5{
                gamespeed += 0.1//1.1
                countDownNum -= 1
            } else if countDownNum == 4{
                gamespeed += 0.1//1.2
                countDownNum -= 1
            } else if countDownNum == 3{
                gamespeed += 0.1//1.3
                countDownNum -= 1
            } else if countDownNum == 2{
                gamespeed += 0.1//1.4
                countDownNum -= 1
            } else if countDownNum == 1{
                gamespeed += 0.1//1.5
                countDownNum -= 1
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
