//
//  RecommentViewModel.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/19.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

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
        NetworkTools.requestData(type: .Get, URLString: "http://httpbin.org/get") { (response) in
            print(response)
        }
        //1.推荐数据
        
        
        
        //2.颜值数据
        
        
        //3.后面部分的游戏数据
        
        
        
    }
    
    
}

