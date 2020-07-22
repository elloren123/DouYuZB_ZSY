//
//  RecommentGameView.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/22.
//  Copyright © 2020 LEPU. All rights reserved.
/*
 10个横向滚动的游戏图标
 */

import UIKit

private let kRecommentGameCellID = "kRecommentGameCellID"

class RecommentGameView: UIView {
    //MARK: - 属性
    @IBOutlet weak var collectionView: UICollectionView!
    //数据源
    var anchorGroup :[AnchorGroup]? {
        didSet{
            collectionView.reloadData()
            
        }
    }
    
    
    //MARK: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIView.AutoresizingMask()
        //注册cell
        collectionView.register(UINib(nibName: "RecommentGameViewCell", bundle: nil), forCellWithReuseIdentifier: kRecommentGameCellID)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //配置 layout
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = CGSize(width: 80, height: 90)
        
    }
    
}

//MARK: - 快速创建
extension RecommentGameView {
    class func recommentGameView() -> RecommentGameView {
        return Bundle.main.loadNibNamed("RecommentGameView", owner: nil, options: nil)?.first as! RecommentGameView
    }
}

//MARK: -

extension RecommentGameView :UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorGroup?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommentGameCellID, for: indexPath) as! RecommentGameViewCell
        cell.anchor = anchorGroup?[indexPath.row]
        return cell
    }
}
