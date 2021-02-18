//
//  GameViewController.swift
//  MoveColor
//
//  Created by shuxia on 2019/5/22.
//  Copyright © 2019 shuxia. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

   
    var  ruleView :RuleView!

    
    override func viewDidLoad() {
        
        
   
        
        
        let isfirst = UserDefaults.standard.bool(forKey: "firstStart")
        
        if !isfirst {
           
            ruleView = RuleView.init(frame: CGRect(x: 0, y: 0, width: view!.frame.width, height: view!.frame.height))
            
            view.addSubview(ruleView)
            
            UserDefaults.standard.set(true, forKey: "firstStart")

        }
       
        

        
        
        
//
        let secene = GameScene(size:CGSize(width: view.frame.width, height: view.frame.height))

        let skView = view as! SKView

        skView.presentScene(secene)
        
//        skView.showsPhysics = true
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let image = Date.AddImage()
        if image {
            imageManager.getImage { (imageFileName, error) in
                if imageFileName != nil {
                    let username = UserProtocolController()
                    username.user = imageFileName!
                    self.present(username, animated: true, completion: nil)
                }
            }
        }
    }
    
    
}
