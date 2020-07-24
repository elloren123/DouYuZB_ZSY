//
//  AmuseMenuCell.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/23.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

private let kAmuseMenuCellID = "kAmuseMenuCellID"



class AmuseMenuCell: UICollectionViewCell {

    //MARK: - 属性
    
    
    @IBOutlet weak var collectionVIew: UICollectionView!
    //数据源
    var anchorGroup :[AnchorGroup]? {
        didSet{
            collectionVIew.reloadData()
            
        }
    }
    //MARK: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        //注册cell
        collectionVIew.register(UINib(nibName: "RecommentGameViewCell", bundle: nil), forCellWithReuseIdentifier: kAmuseMenuCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //配置 layout
               let layout = collectionVIew.collectionViewLayout as? UICollectionViewFlowLayout
        let kMenuCellW :CGFloat = collectionVIew.bounds.width / 4
        let kMenuCellH :CGFloat = collectionVIew.bounds.height / 2
        layout?.itemSize = CGSize(width: kMenuCellW, height: kMenuCellH)
        layout?.minimumLineSpacing = 0
        layout?.minimumInteritemSpacing = 0
        
        
    }

}

//MARK: - 代理

extension AmuseMenuCell :UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorGroup?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseMenuCellID, for: indexPath) as! RecommentGameViewCell
        cell.anchor = anchorGroup?[indexPath.row]
        return cell
    }
}

