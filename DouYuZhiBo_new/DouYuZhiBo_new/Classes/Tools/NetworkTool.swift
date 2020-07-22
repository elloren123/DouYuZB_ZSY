//
//  NetworkTool.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/21.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType {
    case Get
    case Post
}

class NetworkTool {
    //封装一个简易的网络请求
    class func reloadData(_ type:MethodType,_ urlString:String,paramsters:[String:Any]? = nil,finishCallback:@escaping (_ result:Any) -> ()){
        let method = type == .Get ? HTTPMethod.get : HTTPMethod.post
        
        AF.request(urlString, method: method, parameters: paramsters).responseJSON { (response) in
            //获取结果
            switch response.result {
            case .success:
                //将结果回调出去
                finishCallback(response.data!)
            case .failure:
                let statusCode = response.response?.statusCode
                debugPrint("\(statusCode ?? 0)请求失败")
            }
          
        }
       
    }
    
    /// JSONString转换为字典
     class func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        
           let jsonData:Data = jsonString.data(using: .utf8)!
        
           let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
           if dict != nil {
               return dict as! NSDictionary
           }
           return NSDictionary()
            
        
       }
       
       ///JSONString转换为数组
      class func getArrayFromJSONString(jsonString:String) ->NSArray{
            
           let jsonData:Data = jsonString.data(using: .utf8)!
            
           let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
           if array != nil {
               return array as! NSArray
           }
           return array as! NSArray
            
       }
    
    
    
}
