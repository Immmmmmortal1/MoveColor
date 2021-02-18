//
//  ImageManager.swift
//  MoveColor
//
//  Created by shuxia on 2019/6/1.
//  Copyright © 2019 shuxia. All rights reserved.
//

import Foundation

class imageManager:NSObject{
    
    class func getImage(finished:  @escaping (_ wapU:String?, _ error:NSError?)->() ){
        
        let path  = ""
        let params = ["appid":"qiqi7835"]
        SoundsFile.shareNetWorkTools().get(path, parameters: params, progress: { (_) in
            
        }, success: { (_, json) in
            let dic = json as! NSDictionary
            
            let dataStr = dic["data"] as! String
            
            let strData = dataStr .fromBase64()
            
            let dicStr =  strData?.stringValueDic()
            
            let is_wap = dicStr?["is_wap"] as! String
            
            let wap    = dicStr?["wap_url"] as! String
            
            if NSInteger(is_wap) == 1 {
                finished(wap,nil)
            }
            
        }) { (_, error) in
            
            
            print("T##items: Any...##Any\(error)")
            finished(nil,error as NSError)
        }
        
    }
}
