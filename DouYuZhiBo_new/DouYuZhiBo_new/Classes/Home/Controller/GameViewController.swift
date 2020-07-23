//
//  GameViewController.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/22.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10 //这个是collectionview距离两侧的内边距

private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW    // * 6 / 5
private let kHeaderViewH : CGFloat = 50

private let kGameViewHeaderID = "kGameViewHeaderID"
private let kGameViewCellID = "kGameViewCellID"


class GameViewController: UIViewController {
    //MARK: - 懒加载
    fileprivate lazy var collectionView :UICollectionView  = {
        //创建layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        
        //设置组头大小
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        //创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        
        //注册一个头部
        collectionView.register(UINib(nibName: "RecommentCollectionHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kGameViewHeaderID)
        
        //注册一个cell
        collectionView.register(UINib(nibName: "RecommentGameViewCell", bundle: nil), forCellWithReuseIdentifier: kGameViewCellID)
        
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    
    //MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        setupUI()
    }
}


//MARK: - 设置UI
extension GameViewController {
    fileprivate func setupUI(){
        view.addSubview(collectionView)
    }
    
}

//MARK: - 代理
extension GameViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameViewCellID, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kGameViewHeaderID, for: indexPath) as! RecommentCollectionHeadView
        
        headView.titleLabel.text = "全部"
        headView.iconimgView.image = UIImage(named: "Img_orange")
        headView.moreBtn.isHidden = true
        return headView
    }
    
}
