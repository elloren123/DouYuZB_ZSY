//
//  GameViewController.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/22.
//  Copyright © 2020 LEPU. All rights reserved.
/*
 游戏
 */

import UIKit

private let kEdgeMargin : CGFloat = 10 //这个是collectionview距离两侧的内边距

private let kGameItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kGameItemW
private let kHeaderViewH : CGFloat = 50
private let kGameViewH : CGFloat = 90

private let kGameViewHeaderID = "kGameViewHeaderID"
private let kGameViewCellID = "kGameViewCellID"


class GameViewController: BaseViewController {
    
    //MARK: - 懒加载
    fileprivate lazy var gameVM:GameViewModel = GameViewModel()
    
    fileprivate lazy var collectionView :UICollectionView  = {[unowned self] in
        //创建layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: kGameItemW, height: kItemH)
        //设置组头大小
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        //给layout设置组的内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        
        //创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        //设置内边距,这里设置的话,会导致collectionView都有内边距,header也被限制了,并不是我们需要的,-->改为layout设置
//        collectionView.contentInset = UIEdgeInsets(top:kHeaderViewH + kGameViewH, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        //collectionview拉伸导致遮挡的处理
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        //注册一个头部
        collectionView.register(UINib(nibName: "RecommentCollectionHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kGameViewHeaderID)
        
        //注册一个cell
        collectionView.register(UINib(nibName: "RecommentGameViewCell", bundle: nil), forCellWithReuseIdentifier: kGameViewCellID)
        
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    fileprivate lazy var topHeaderView:RecommentCollectionHeadView = {
        let headView = RecommentCollectionHeadView.recommentCollectionHeadView()
        headView.titleLabel.text = "常用"
        headView.iconimgView.image = UIImage(named: "Img_orange")
        headView.moreBtn.isHidden = true
        headView.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: kScreenW, height: kHeaderViewH)
        return headView
    }()
    
    fileprivate lazy var topGameView:RecommentGameView = {
        let topGameView = RecommentGameView.recommentGameView()
        topGameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return topGameView
    }()
    
    
    //MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        reloadData()
    }
}


//MARK: - 设置UI
extension GameViewController {
    fileprivate func setupUI(){
        view.addSubview(collectionView)
        coverView = collectionView
        collectionView.isHidden = true
        collectionView.addSubview(topHeaderView)
        collectionView.addSubview(topGameView)
        collectionView.contentInset = UIEdgeInsets(top:kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
    
}

//MARK: - 请求数据
extension GameViewController {
    fileprivate func reloadData(){
        gameVM.reloadData {[unowned self] in
            self.collectionView.reloadData()
            
            if self.gameVM.gameGroup.count > 10 {
                
                let arr = Array( self.gameVM.gameGroup[0..<10] )
                
                self.topGameView.anchorGroup = arr 
            }
            self.removeImgV()
        }
        
        
        
    }
}


//MARK: - 代理
extension GameViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.gameVM.gameGroup.count > 30 {
            return 30
        }else {
            return  self.gameVM.gameGroup.count
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameViewCellID, for: indexPath) as! RecommentGameViewCell
        
        cell.anchor = gameVM.gameGroup[indexPath.row]
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
