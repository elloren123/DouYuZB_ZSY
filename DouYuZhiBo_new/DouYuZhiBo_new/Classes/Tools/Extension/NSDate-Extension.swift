//
//  NSDate-Extension.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/19.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

extension Date {
    //MARK: - 获取当前时间的秒数
    static func getCurrentTime() -> String{
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
