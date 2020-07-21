//
//  AnchorGroup.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/19.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit
import HandyJSON

class AnchorGroup: HandyJSON {
    
    //这两个是组头的信息;
    var tag_name : String = ""
    var icon_name : String = "home_header_normal" //这个的图片加载 是本地的图片
    
    //这个是给横向滑动的 View的 图片展示使用的
    var icon_url : String = ""
    
    /// 该组中对应的房间信息
    var anchors : [RoomAnchorModel] = [RoomAnchorModel]()
    
    required init() {}
    
}
