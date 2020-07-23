//
//  RecommentGameViewCell.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/22.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

class RecommentGameViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImgView: UIImageView!
    
    var anchor :AnchorGroup? {
        didSet {
            titleLabel.text = anchor?.tag_name
            //用""创建 URL会为 nil
            if let url = URL(string: anchor?.icon_url ?? "") {
                iconImgView.kf.setImage(with: url)
            }else{
                iconImgView.image = UIImage(named: "home_more_btn")
            }
            
            
        }
    }
    
    
    

}
