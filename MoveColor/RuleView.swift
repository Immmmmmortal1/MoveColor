//
//  RuleView.swift
//  MoveColor
//
//  Created by shuxia on 2019/5/26.
//  Copyright © 2019 shuxia. All rights reserved.
//

import UIKit

class RuleView: UIView {
    
    
    var ruleLabel : UILabel!
    var ruleBack  :UIImageView!
    
    
    override init(frame: CGRect) {
        

        super.init(frame: frame)
        
        
        
        ruleBack = UIImageView.init(image: UIImage.init(named: "ruleBack"))
        
        ruleBack.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        
        ruleBack.center = self.center
        ruleBack.contentMode = UIView.ContentMode.scaleAspectFit
        
        
        self.addSubview(ruleBack)
        
        
        self.backgroundColor  = UIColor.clear
        
        ruleLabel  = UILabel.init(frame: CGRect(x: 0, y: 0, width: self.frame.width*0.6, height: self.frame.height*0.4))
        ruleLabel.center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        ruleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        ruleLabel.numberOfLines = 0;
        ruleLabel.text = "1.Drag the balloon to move.\n 2.Don't let the balloon touch the falling stone .\n 3.The balloon will gradually increase.\n 4.You can collide with the bomb to reduce the size of the balloon so that it can pass more easily.";

        
        self.addSubview(ruleLabel)
    
        
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubViews()  {
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }

    
}
