//
//  RecommentViewModel.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/19.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit
import Alamofire
class RecommentViewModel {
    //MARK: - 懒加载属性
    //??? fileprivate 是什么意思? TODO
    
    //组的信息 (推荐 + 颜值 + 游戏)
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    
    //推荐
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    
    //颜值
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
    
    lazy var cycleModels : [RecommentCycleModel] = [RecommentCycleModel]()
    
}

//MARK: - 发送网络请求
extension RecommentViewModel {
    /*
     斗鱼推荐界面,发送了三个网络请求获取数据:
     1.推荐数据
     2.颜值数据
     3.后面部分的游戏数据
     */
    
    func requestData(_ finishCallback : @escaping () -> ()){
        
       let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()] //["limit" : "4", "offset" : "0", "time" : "1474252024"] //
        
        //0.排序
        let dGroup = DispatchGroup()
        
        //1.推荐数据
        dGroup.enter()
        let bigURL = "http://capi.douyucdn.cn/api/v1/getbigDataRoom"
        NetworkTool.reloadData(.Get, bigURL, paramsters: ["time" : Date.getCurrentTime()]) { (response) in
            let json = String(data: response as! Data, encoding: String.Encoding.utf8)
            let dict:NSDictionary =  NetworkTool.getDictionaryFromJSONString(jsonString: json ?? "")
            //设置热门组的 组信息
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            //添加热门组的房间信息
            guard let roomList = dict["data"] as? [[String : Any]] else { return }
            for roomDic in roomList{
                let roomModel = RoomAnchorModel.deserialize(from: roomDic)
                self.bigDataGroup.anchors.append(roomModel!)
            }
            dGroup.leave()
        }
        
        //2.颜值数据
        dGroup.enter()
        let prettyURL = "http://capi.douyucdn.cn/api/v1/getVerticalRoom"
        NetworkTool.reloadData(.Get, prettyURL, paramsters: parameters) { (response) in
            let json = String(data: response as! Data, encoding: String.Encoding.utf8)
            let dict:NSDictionary =  NetworkTool.getDictionaryFromJSONString(jsonString: json ?? "")
            //设置颜值组的 组信息
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            //添加颜值组的房间信息
            guard let roomList = dict["data"] as? [[String : Any]] else { return }
            for roomDic in roomList{
                let roomModel = RoomAnchorModel.deserialize(from: roomDic)
                self.prettyGroup.anchors.append(roomModel!)
            }
            dGroup.leave()
        }
        
        //3.后面部分的游戏数据
          //这里的时间要的是秒;--->这个时间秒数很多地方需要用到,这里扩充一个extension
        dGroup.enter()
        let gameURL = "http://capi.douyucdn.cn/api/v1/getHotCate"
        
        NetworkTool.reloadData(.Get, gameURL, paramsters: parameters) { (response) in
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
            dGroup.leave()
        }
        
        // 4所有的数据都请求到,之后进行排序
        dGroup.notify(queue: DispatchQueue.main){
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            //5 数据回调
            finishCallback()
        }

    }
    
    //请求轮播数据
    
    func reloadCycleData(_ finishCallback:@escaping () -> () ){
        let cycleURL = "http://www.douyutv.com/api/v1/slide/6"
        let parameters = ["version":"2.300"]
        NetworkTool.reloadData(.Get, cycleURL,paramsters: parameters) { (response) in
            let json = String(data: response as! Data, encoding: String.Encoding.utf8)
            let dict:NSDictionary =  NetworkTool.getDictionaryFromJSONString(jsonString: json ?? "")
            guard let dataArray = dict["data"] as? [[String : Any]] else { return }
            
            for diction in dataArray {
                let model = RecommentCycleModel.deserialize(from: diction)
                
                guard let room = diction["room"] as? [String : Any] else { return }
               
                let roomModel = RoomAnchorModel.deserialize(from: room)
                model?.anchors = roomModel!
                
                self.cycleModels.append(model!)
            }
            
            finishCallback()
        }
        
        
    }
    
}

