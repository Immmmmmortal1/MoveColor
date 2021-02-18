//
//  Base64.swift
//  flappyBird
//
//  Created by shuxia on 2019/5/8.
//  Copyright © 2019 shuxia. All rights reserved.
//

import Foundation
extension String {
    // base64编码
   public func toBase64() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    // base64解码
   public func fromBase64() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
   public func stringValueDic() -> [String : Any]?{
        let data = self.data(using: String.Encoding.utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
            return dict
        }
        return nil
    }

}
