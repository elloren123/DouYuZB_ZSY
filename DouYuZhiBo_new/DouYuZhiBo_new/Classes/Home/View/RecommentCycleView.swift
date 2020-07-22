//
//  RecommentCycleView.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/21.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

class RecommentCycleView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸,如果不设置,会导致被拉伸
        autoresizingMask = UIView.AutoresizingMask()
    }
    

}

//MARK: - 快速创建
extension RecommentCycleView {
    class func recommentCycleView() -> RecommentCycleView {
        return Bundle.main.loadNibNamed("RecommentCycleView", owner: nil, options: nil)?.first as! RecommentCycleView
    }
    
}

