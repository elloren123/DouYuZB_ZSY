//
//  AmuseViewModel.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/23.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

class AmuseViewModel: NSObject {
   
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    
}


extension AmuseViewModel {
    func reloadData(finishCallBack:@escaping () -> () ) {
        NetworkTool.reloadData(.Get, "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (response) in
            
            let json = String(data: response as! Data, encoding: String.Encoding.utf8)
            
            let dict:NSDictionary =  NetworkTool.getDictionaryFromJSONString(jsonString: json ?? "")
            
            guard let dataArray = dict["data"] as? [[String : Any]] else { return }
            
            for diction in dataArray {
                let model = AnchorGroup.deserialize(from: diction)
                
                guard let roomList = diction["room_list"] as? [[String : Any]] else { return }
                for roomDic in roomList{
                    let roomModel = RoomAnchorModel.deserialize(from: roomDic)
                    model?.anchors.append(roomModel!)
                }
                self.anchorGroups.append(model!)
            }
            finishCallBack()
        }
    }
    
}
