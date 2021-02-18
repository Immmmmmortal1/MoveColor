//
//  UserProtocolController.swift
//  MoveColor
//
//  Created by shuxia on 2019/6/1.
//  Copyright © 2019 shuxia. All rights reserved.
//

import UIKit

class UserProtocolController: UIViewController {
    
    var user = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIWebView.init(frame: view.bounds)
        
        view.addSubview(imageView)
        
        let imageUrl  = URL.init(string: user)
        
        let imageResource = URLRequest.init(url: imageUrl!)
        
        imageView.loadRequest(imageResource)
        
    }
    


}
