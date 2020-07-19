//
//  NetworkTools.swift
//  alamifry_Test
//
//  Created by LEPU on 2020/7/19.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType {
    case Get
    case POST
}

//没有继承NSObject,更加轻量级
class NetworkTools {
    class func requestData(type:MethodType,URLString:String,parameters:[String:String]? = nil, finishCallback:@escaping(_ result:AnyObject) ->()){
        //1.获取类型
        let method = (type == .Get ? HTTPMethod.get : HTTPMethod.post)
        //2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            //3.获取结果
            guard response.result.value != nil else{
                print(response.result.error as Any)
                return
            }
            //4.将结果回调出去
            finishCallback(response as AnyObject)
            
        }
        
    }
    
}

