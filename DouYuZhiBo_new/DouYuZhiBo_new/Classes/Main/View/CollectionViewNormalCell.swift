//
//  CollectionViewNormalCell.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/18.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionViewNormalCell: UICollectionViewCell {
    //MARK: - 属性
   
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var iconImageVIew: UIImageView!
    
    
    
    var anchor :RoomAnchorModel? {
        didSet {
            roomNameLabel.text = anchor?.room_name
            
            var onlineNum:String = ""
            if anchor!.online >= 10000 {
                onlineNum = "\(Int(anchor!.online / 10000))万在线"
            }else{
                onlineNum = "\(anchor!.online)在线"
            }
            onlineBtn.setTitle(onlineNum, for: .normal)
            
            nickNameLabel.text = anchor?.nickname
            guard let url =  URL(string: anchor?.vertical_src ?? "") else {
                return
            }
            iconImageVIew.kf.setImage(with:url)
        }
    }
    

}
