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
    convenience init(imageName:String,highImageName:String,size:CGSize) {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        btn.setImage(UIImage.init(named: highImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        self.init(customView:btn)
    }
    
    
}
