//
//  RecommentCycleView.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/21.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

private let kRecommentCycleCellID = "kRecommentCycleCellID"

class RecommentCycleView: UIView {
    //MARK: - 控件属性
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
  
    
    //MARK: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸,如果不设置,会导致被拉伸
        //也可以通过xib设置 -->具体看笔记
//        autoresizingMask = UIView.AutoresizingMask()
        
        //注册cell
//        collectionview.register(UINib(nibName: "RecommentCycleViewCell", bundle: nil), forCellWithReuseIdentifier: kRecommentCycleCellID)
        
        collectionview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kRecommentCycleCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置collectionviewlayout
        let layout = collectionview.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionview.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        
    }
    

}

//MARK: - 快速创建
extension RecommentCycleView {
    class func recommentCycleView() -> RecommentCycleView {
        return Bundle.main.loadNibNamed("RecommentCycleView", owner: nil, options: nil)?.first as! RecommentCycleView
    }
    
}

//MARK: - UICollectionViewDataSource
extension RecommentCycleView:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommentCycleCellID, for: indexPath)
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.purple :UIColor.red
        return cell
    }
    
}
