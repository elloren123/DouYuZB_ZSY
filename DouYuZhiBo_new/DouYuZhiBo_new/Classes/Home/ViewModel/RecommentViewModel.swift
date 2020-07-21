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
    
}

//MARK: - 发送网络请求
extension RecommentViewModel {
    /*
     斗鱼推荐界面,发送了三个网络请求获取数据:
     1.推荐数据
     2.颜值数据
     3.后面部分的游戏数据
     */
    
    func requestData(){
        
//       let parameters = ["limit" : "4", "offset" : "0", "time" : "1474252024"] //["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        
        //1.推荐数据
        
        
        
        //2.颜值数据
        
        
        //3.后面部分的游戏数据
          //这里的时间要的是秒;--->这个时间秒数很多地方需要用到,这里扩充一个extension
        
//        let gameURL = "http://capi.douyucdn.cn/api/v1/getHotCate"
//        NetworkTools.requestData(.Get, URLString: gameURL, parameters: parameters) { (result) in
//            print(result)
//            //1.转字典
//            guard let resultDict = result as? [String:NSObject] else {return}
//            //2.获取数据
//            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else {return}
//            //3.遍历数据,得到模型
//            for dict in dataArray {
//                //模型转换,没有比较好的第三方框架? --->这里自己写一个
//
//            }
//
//        }
        let url = "http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1474252024"
        AF.request(url).responseJSON{ (response) in
            print(response)
        }
        
        
    }
    
    
}

