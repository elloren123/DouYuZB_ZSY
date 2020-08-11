//
//  UIColor_Extension.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/17.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

extension UIColor {
    /**
    convenience:便利，使用convenience修饰的构造函数叫做便利构造函数
         便利构造函数通常用在对系统的类进行构造函数的扩充时使用。
         便利构造函数的特点：
         1、便利构造函数通常都是写在extension里面
         2、便利函数init前面需要加载convenience
         3、在便利构造函数中需要明确的调用self.init()
    
    */
    
    //MARK: RGB颜色
    convenience init(R:CGFloat,G:CGFloat,B:CGFloat){
        self.init(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: 1)
    }
    //MARK: 随机色
    class func randomColor() -> UIColor {
        return UIColor(R: CGFloat(arc4random_uniform(256)), G: CGFloat(arc4random_uniform(256)), B: CGFloat(arc4random_uniform(256)))
    }
    
}


