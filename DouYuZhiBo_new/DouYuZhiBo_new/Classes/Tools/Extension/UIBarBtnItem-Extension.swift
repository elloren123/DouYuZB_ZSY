//
//  UIBarBtnItem-Extension.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/17.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    //给BarBtnItem扩展一个类方法,这种方式,不是很好,Swift中更多的是使用构造函数
    class func createItem(imageName:String,highImageName:String,size:CGSize) ->UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        btn.setImage(UIImage.init(named: highImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    
    //这种是常用的方式
    //便利构造函数,要以convenience开头;函数中必须调用设计的构造函数(self调用的)
    //考虑到其他的地方可能也要创建BarButtonItem,而且可能不需要highImageName,这里给出默认参数
    //size同理
    convenience init(imageName:String,highImageName:String = "",size:CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        if highImageName != ""{
            btn.setImage(UIImage.init(named: highImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView:btn)
    }
    
    
}
