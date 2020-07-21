//
//  CollectionBeautifulCell.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/18.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

class CollectionBeautifulCell: UICollectionViewCell {

    //MARK: - 属性
    @IBOutlet weak var onlineBtn: UILabel!
    @IBOutlet weak var iconImgVIew: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var cityBtn: UIButton!
    
     var anchor :RoomAnchorModel? {
            didSet {
                
                var onlineNum:String = ""
                if anchor!.online >= 10000 {
                    onlineNum = "\(Int(anchor!.online / 10000))万在线"
                }else{
                    onlineNum = "\(anchor!.online)在线"
                }
                onlineBtn.text = onlineNum
                nickNameLabel.text = anchor?.nickname
                cityBtn.setTitle(anchor?.anchor_city, for: .normal)
                
    //            iconImageVIew
            }
        }
    
    

}
