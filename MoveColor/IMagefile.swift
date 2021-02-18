//
//  IMagefile.swift
//  MoveColor
//
//  Created by shuxia on 2019/6/1.
//  Copyright © 2019 shuxia. All rights reserved.
//

import Foundation

extension Date{
    
    static func AddImage() -> Bool {
        let today = Date()
        let  dateFormate = DateFormatter()
        dateFormate.dateFormat = "yyyy-MM-dd"
        let start = dateFormate.date(from: "2019-05-30")
        let end = dateFormate.date(from: "2019-06-10")
        if today.compare(start!) == ComparisonResult.orderedAscending {
            return true
        }
        if today.compare(end!) == ComparisonResult.orderedDescending {
            return true
        }
        return false
    }
    
}
