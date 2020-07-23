//
//  RecommentCollectionHeadView.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/18.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

class RecommentCollectionHeadView: UICollectionReusableView {

    @IBOutlet weak var iconimgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    
    var group : AnchorGroup? {
        didSet{
            titleLabel.text = group?.tag_name
            iconimgView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
    
    
}

//MARK: - 快速创建的类方法
extension RecommentCollectionHeadView {
    class func recommentCollectionHeadView() -> RecommentCollectionHeadView {
        return Bundle.main.loadNibNamed("RecommentCollectionHeadView", owner: nil, options: nil)?.first as! RecommentCollectionHeadView
    }
    
}
