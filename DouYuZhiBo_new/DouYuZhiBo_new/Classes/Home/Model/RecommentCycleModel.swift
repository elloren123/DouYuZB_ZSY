//
//  RecommentCycleModel.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/22.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit
import HandyJSON

class RecommentCycleModel: HandyJSON {
    var title:String = ""
    var pic_url:String = ""
    var anchors : RoomAnchorModel = RoomAnchorModel()
    required init() {}
}
