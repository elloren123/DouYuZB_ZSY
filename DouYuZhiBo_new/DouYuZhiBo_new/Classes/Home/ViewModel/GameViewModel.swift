//
//  GameViewModel.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/23.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

class GameViewModel {

    var gameGroup:[GameModel] = [GameModel]()
    
    
    
}

extension GameViewModel {
    func reloadData(finishCallBack:@escaping () -> () ) {
        NetworkTool.reloadData(.Get, "http://capi.douyucdn.cn/api/v1/getColumnDetail") { (response) in
            
            let json = String(data: response as! Data, encoding: String.Encoding.utf8)
            let dict:NSDictionary =  NetworkTool.getDictionaryFromJSONString(jsonString: json ?? "")
            
            //添加颜值组的房间信息
            guard let roomList = dict["data"] as? [[String : Any]] else { return }
            for roomDic in roomList{
                let roomModel = GameModel.deserialize(from: roomDic)
                self.gameGroup.append(roomModel!)
            }
            finishCallBack()
        }
    }
    
}
