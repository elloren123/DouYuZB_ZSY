//
//  BaseViewModel.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/24.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

class BaseViewModel: NSObject {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    func reloadData(url:String,paramsters:[String:Any]? = nil, finishCallBack:@escaping () -> () ) {
        NetworkTool.reloadData(.Get, url,paramsters: paramsters) { (response) in
            
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
