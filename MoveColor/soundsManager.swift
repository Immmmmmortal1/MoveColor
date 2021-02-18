//
//  soundsManager.swift
//  MoveColor
//
//  Created by shuxia on 2019/6/1.
//  Copyright © 2019 shuxia. All rights reserved.
//

import UIKit

import AFNetworking

class SoundsFile: AFHTTPSessionManager {
    
    
    static let tools: SoundsFile = {
        
        let baseUrl = NSURL.init(string: "http://app.11qdcp.com/lottery/back/api.php")
        let t = SoundsFile.init(baseURL: baseUrl! as URL  ,sessionConfiguration:URLSessionConfiguration.default)
        t.responseSerializer.acceptableContentTypes = NSSet.init(objects: "application/json", "text/json", "text/javascript","text/plain","text/html") as? Set<String>
        return t
    }()
    
    
    class func shareNetWorkTools() ->SoundsFile {
        return tools
    }
}
