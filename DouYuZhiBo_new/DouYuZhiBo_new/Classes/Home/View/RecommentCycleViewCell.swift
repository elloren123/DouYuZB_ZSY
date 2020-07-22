//
//  RecommentCycleViewCell.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/22.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

class RecommentCycleViewCell: UICollectionViewCell {

   //MARK: - 属性
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel: RecommentCycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            guard let imgURL = URL(string: cycleModel?.pic_url ?? "") else{return}
            iconImgView.kf.setImage(with: imgURL)
            
        }
    }
    
    

}
