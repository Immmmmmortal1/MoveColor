//
//  GameScene.swift
//  MoveColor
//
//  Created by shuxia on 2019/5/22.
//  Copyright © 2019 shuxia. All rights reserved.
//
/**
 一起下来   但是速度会  越来越快
 
 **/


import SpriteKit
import GameplayKit

enum GameStatus {
    case idle // 初始化
    case running  //运行中
    case over      //结束
    
}

class GameScene: SKScene ,SKPhysicsContactDelegate{
    
    

    
    
    
    
    
    ////创建 playerColor
    var colorNode :SKSpriteNode!
    var boombNode : SKSpriteNode!
    
    
    let scale = CGFloat(91.0/329)

    ///设置  精灵的 大小
    let playerColorWidth = CGFloat(80)
    let playerColorHeight = CGFloat(80)
    
    let npcWidth = CGFloat(60)
    
    let   baseWidth = CGFloat(60)
    
    ///初始化 游戏状态
    
    var gameState : GameStatus = .idle
    

    ///声明 可碰撞的 物体
    let playerColor :UInt32 = 0x1 << 0
    let colorBlock  :UInt32 = 0x1 << 1
    let BoomBlock   :UInt32 = 0x1 << 2



    
    override func didMove(to view: SKView) {
//        backgroundColor = UIColor.blue
        
        let backNode = SKSpriteNode(texture: SKTexture(imageNamed: "backNodeG"), size: view.frame.size)
        backNode.anchorPoint  = CGPoint(x: 0, y: 0)
        
        addChild(backNode)
        

        //给场景添加物理场

        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)  /// 物理世界的重力
        self.physicsWorld.contactDelegate = self;
 

        //初始化
        
        initGame()
        

        
    }
    
    //:背景音乐
    func initBackMusic() {
        let backM  = SKAudioNode(fileNamed: "background")
        
        backM.autoplayLooped = true
        
        addChild(backM)
    }
    //:爆炸音乐
    func initExplose()  {
        
        let bombAction = SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false)
        run(bombAction)
        
    }
    //:死亡音乐
    func initDiedM()  {
        
        let bombAction = SKAction.playSoundFileNamed("ninjaHit.wav", waitForCompletion: false)
        run(bombAction)
        
    }

    
    /*初始化 方法 */
    func initGame()  {
        
        //添加 tapLaBEL 到屏幕中间
        tapNode.position = CGPoint(x: view!.frame.size.width/2, y:  view!.frame.size.height/2)
        
        addChild(tapNode)
        
        ///开始创建角色
        createPlayer()
        moveQiQiu()

        
    }
    
    ///移动气球
    func moveQiQiu() {
        

        
        let sizeA = SKAction.resize(toWidth: 200, height: 200 * scale , duration: 0.5)
        let  wait = SKAction.wait(forDuration: 0.5)
        let sizeB = SKAction.resize(toWidth: 100, height: 100 * scale, duration: 0.5)

        tapNode.run(SKAction.repeatForever(SKAction.sequence([sizeA,wait,sizeB])), withKey: "moveQiQiu")
        

        
        
        let mainPath = UIBezierPath()
        
        mainPath.move(to: CGPoint(x:0, y:0))
        
        mainPath.addLine(to: CGPoint(x: 100 , y: 200))
        
        
        mainPath.addLine(to: CGPoint(x: -100 , y: 400))

        
        mainPath.addLine(to: CGPoint(x: -50 , y: 200 ))

      
        
        mainPath.close()

        
        let pathA = SKAction.follow(mainPath.cgPath, asOffset: true, orientToPath: false,duration: 8)
        
        
        colorNode.run(SKAction.repeatForever(pathA), withKey: "mainPath")
        
    }
    
    func removePlayAction()  {
    
        colorNode.removeAction(forKey: "mainPath")
        
        tapNode.removeFromParent()
        tapNode.removeAction(forKey: "moveQiQiu")
        
    }
    /*** 游戏开始**/
    func startGame()  {
        
        gameState = .running
        
        startCreate()
        
        initBackMusic()


    }
    /**游戏结束***/
    func gameOver()  {

        gameState = .over

        ///移除所有的  run
        
        //移除 石块的创建
        removeAction(forKey: "createBlocks")
        //y移除气球的增大
        removeAction(forKey: "addqiqiu")
        //移除炸弹的创建
        removeAction(forKey: "createBooms")
        
        //停止交互  结束 的label  移到屏幕中间  再开始
         isUserInteractionEnabled = false
        
        for block in self.children where block.name == "npc"  ||  block.name == "boom" || block.name == "qiqiu" {
            //循环检查场景的子节点，同时这个子节点的名字要为
            block.removeFromParent()//将水管这个节点从场景里移除掉
        }
        
    }
    
    func createGameOverLabel()  {
        
        gameOverLabel.position = CGPoint(x: view!.frame.width*0.5, y: view!.frame.height)
        
        addChild(gameOverLabel)

        //让 gameoverLabel 通过一个人动画 action 移动到 屏幕中间
        let moveAction = SKAction.move(to: CGPoint(x: view!.frame.width*0.5, y: view!.frame.height*0.5), duration: 0.5)
        gameOverLabel.run(moveAction) {
            self.isUserInteractionEnabled = true
        }
    }
    
    func removeGameOverLabel()  {

        gameOverLabel.removeFromParent()

    }

    /***创建玩家角色**/
    func createPlayer()  {

        let colorNodeTextTure = SKTexture(imageNamed:"qiqiu")
        colorNode = SKSpriteNode(texture: colorNodeTextTure, size: CGSize(width: playerColorWidth, height: playerColorHeight))
        colorNode.position = CGPoint(x: view!.frame.width/2, y: playerColorHeight)
        colorNode.name = "qiqiu";
 
        addChild(colorNode)
        

        colorNode.physicsBody = SKPhysicsBody(texture: colorNode.texture!, size: colorNode.size)
        colorNode.physicsBody?.categoryBitMask = playerColor
        colorNode.physicsBody?.contactTestBitMask = colorBlock | BoomBlock //设置可以玩家碰撞的物理体
        colorNode.physicsBody?.allowsRotation = false  //禁止旋转
        
        
    }
    
   
    
    
    
    
    
    //创建 随机色块 放置于屏幕外面 然后 遍历所有的色块  开始移动
    func createRandomColorBlocks() {
        
            ///随机的 x 坐标 平分 宽度
        
        
            let blockWidth = npcWidth
        
 
        
        
           let speed = CGFloat(arc4random_uniform(UInt32(5)))
        
           let image = arc4random_uniform(UInt32(5))
        
            let imageName = "block_" + String(image)
            
            let  npcColorBlock = SKSpriteNode(texture: SKTexture(imageNamed: imageName), size: CGSize(width: blockWidth, height: npcWidth))
            
            npcColorBlock.position = CGPoint(x:blockWidth + (view!.frame.width*speed)/5, y: view!.frame.height)
            npcColorBlock.name  = "npc"
            addChild(npcColorBlock)
            
            
            npcColorBlock.physicsBody = SKPhysicsBody(texture: npcColorBlock.texture!, size: npcColorBlock.size)
            npcColorBlock.physicsBody?.categoryBitMask = colorBlock

        
    }
    //创建 炸弹
    func Createboomb()  {
        let speed = CGFloat(arc4random_uniform(UInt32(5))) + 1
        
        let blockWidth = npcWidth
        
        boombNode = SKSpriteNode(texture: SKTexture(imageNamed: "boom"), size: CGSize(width: blockWidth, height: blockWidth))
        
        boombNode.position = CGPoint(x:blockWidth + (view!.frame.width)*speed/5, y: view!.frame.height)
        boombNode.name  = "boom"
        addChild(boombNode)
        
//        let trailNode = SKNode()
//        trailNode.zPosition = 0
//        //trailNode.name = "trail"
//        addChild(trailNode)
//
//        let emitterNode = SKEmitterNode(fileNamed: "ShootTrailRed")! // particles文件夹存放粒子效果
//        emitterNode.targetNode = trailNode  // 设置粒子效果的目标为trailNode => 跟随新建的trailNode
//        boombNode.addChild(emitterNode)    // 在子弹节点Node加上粒子效果;

        
        
        boombNode.physicsBody = SKPhysicsBody(texture: boombNode.texture!, size: boombNode.size)
        boombNode.physicsBody?.categoryBitMask = BoomBlock
        
        
        
    }
    //开始批量创建 色块
    func startCreate()  {
        //创建石块
        let waitAction = SKAction.wait(forDuration: 1, withRange: 1.0)
        //创建添加动作
        let  createAction = SKAction.run {self.createRandomColorBlocks()}
        
        //运行动作 key 使用来标记动作的  可以移除
       run(SKAction.repeatForever(SKAction.sequence([waitAction,createAction])),withKey:"createBlocks")
        
        
        
        // 循环创建炸弹
        
        let boomWaitAction = SKAction.wait(forDuration: 4, withRange: 1.0)
        
        let boomCreateAction = SKAction.run {self.Createboomb()}

        run(SKAction.repeatForever(SKAction.sequence([boomWaitAction,boomCreateAction])),withKey:"createBooms")
        
        
        //增大 气球
        let qiqiuWaitAction = SKAction.wait(forDuration: 2, withRange: 1.0)
        
        let addSize = CGSize(width: 10, height: 10)
        let qiqiuCreateAction = SKAction.run {self.addQIQIUSize(qiqiuSize: addSize)}
        
        run(SKAction.repeatForever(SKAction.sequence([qiqiuWaitAction,qiqiuCreateAction])),withKey:"addqiqiu")
     
    }
    //增大气球的外围
    
    func addQIQIUSize(qiqiuSize:CGSize)  {
        colorNode.size = CGSize(width: colorNode.size.width + qiqiuSize.width, height: colorNode.size.height + qiqiuSize.height)
        
        colorNode.physicsBody = SKPhysicsBody(texture: colorNode.texture!, size: colorNode.size)
        colorNode.physicsBody?.categoryBitMask = playerColor
        colorNode.physicsBody?.contactTestBitMask = colorBlock | BoomBlock //设置可以玩家碰撞的物理体
        colorNode.physicsBody?.allowsRotation = false  //禁止旋转

    }
    
    
    //移动
    func moveColorBlocks()  {
        
        for colorBlock in self.children where colorBlock.name == "npc" {
            
            if let Block = colorBlock as? SKSpriteNode {
                
//                let speed = CGFloat(arc4random_uniform(UInt32(10))) + 1
                Block.position = CGPoint(x: colorBlock.position.x, y: colorBlock.position.y - 3)
                
                if Block.position.y < -Block.size.height*0.5{
                    
                    Block.removeFromParent()
                    
                }
            }
        }
        for Boom in self.children where Boom.name ==  "boom" {
            
            if let boom = Boom as? SKSpriteNode{
                
                boom.position = CGPoint(x: Boom.position.x, y: Boom.position.y - 3)
                if boom.position.y < -boom.size.height*0.5{
                    
                    boom.removeFromParent()
                }
            }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {

        if gameState == .idle {


            
        }
        if gameState == .running {
            moveColorBlocks()

        }
    }
    

    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let bodyA:SKPhysicsBody
        
        let bodyB:SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            bodyA = contact.bodyA
            bodyB = contact.bodyB
        }else{
            bodyA = contact.bodyB
            bodyB = contact.bodyA
        }
        if bodyA.categoryBitMask == playerColor && bodyB.categoryBitMask == BoomBlock {
            print("碰到炸弹")
            initExplose()
            if colorNode.size.width > playerColorWidth {
                
                colorNode.size = CGSize(width: colorNode.size.width - 20, height: colorNode.size.height - 20)
            }

            
        }

        if bodyA.categoryBitMask == playerColor && bodyB.categoryBitMask == colorBlock {

            initDiedM()
            
            gameOver()
            removeGameOverLabel()
            createGameOverLabel()
            
            
        }

    }
    /*屏幕触摸检测*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        

        if gameState == .running {
            return
        }
        guard let touch = touches.first else {
            return
        }
//        let touchLocation = touch.location(in: self) ///获得点击的位置
        /// 判断目前的GameScene场景舞台是哪个state
        switch gameState {
        case .idle:
    
           removePlayAction()
            
            startGame()

            
        case .over:
            removeGameOverLabel()
            
            createPlayer()

            startGame()
            
        default:
            break;
            
            
        }
    }
    //触摸移动
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameState == .running {
            for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        self.colorNode.position = pos
    }

    
    lazy var gameOverLabel :SKLabelNode = {
        
        let OverLable = SKLabelNode(fontNamed: "Chalkduster")
        OverLable.text = "Game Over"
        
        return OverLable
        
    }()
    

    
    lazy var tapNode :SKSpriteNode = {
        let taP = SKSpriteNode(texture: SKTexture(imageNamed: "tap"), size: CGSize(width: 200, height: 200 * scale))
        
        
        return taP
        
    }()
    

    
    
}

/***
 1.SKAction.wait 不能写在  update 方法里面
 2.移动的方法  可以写在  update 里面
 
 
 **/
