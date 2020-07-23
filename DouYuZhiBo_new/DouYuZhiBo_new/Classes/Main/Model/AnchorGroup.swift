//
//  AnchorGroup.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/19.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

class AnchorGroup: BaseModel {
    var icon_name : String = "home_header_normal" //这个的图片加载 是本地的图片
    /// 该组中对应的房间信息
    var anchors : [RoomAnchorModel] = [RoomAnchorModel]()
}
