//
//  UIColor_Extension.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/17.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(R:CGFloat,G:CGFloat,B:CGFloat){
        self.init(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: 1)
    }
    
}
