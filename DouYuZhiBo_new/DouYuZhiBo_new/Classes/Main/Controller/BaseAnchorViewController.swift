//
//  BaseAnchorViewController.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/24.
//  Copyright © 2020 LEPU. All rights reserved.
/*
 
 一个以显示直播为主的 baseVC
 
 */

import UIKit

 let kItemMargin : CGFloat = 10
 let kItemW : CGFloat = (kScreenW - kItemMargin * 3)/2
 let kNormalItemH : CGFloat = kItemW * 3 / 4
 let kHeaderH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kNormalHeaderID = "kNormalHeaderID"



class BaseAnchorViewController: BaseViewController {
    
    //MARK: - 懒加载
     var baseVM:BaseViewModel = BaseViewModel();
    
     lazy var collectionView:UICollectionView = { [unowned self] in
        //创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        
        //创建collectionview
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        //注册cell
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
        //注册Header-->XIB
        collectionView.register(UINib(nibName: "RecommentCollectionHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kNormalHeaderID)
        
        return collectionView
        }()
    
 
    
    //MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        reloadData()
        
        
    }
    
}

//MARK: - 设置UI
extension BaseAnchorViewController {
    @objc func setupUI() {
        view.addSubview(collectionView)
        coverView = collectionView
        collectionView.isHidden = true
        
    }
}

//MARK: - 加载数据源
extension BaseAnchorViewController {
    @objc func reloadData(){

    }
}


extension BaseAnchorViewController:UICollectionViewDataSource {
    @objc func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return baseVM.anchorGroups[section].anchors.count
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.row]
        return cell
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kNormalHeaderID, for: indexPath) as! RecommentCollectionHeadView
        headerView.group = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
    
    
}

// MARK:- 遵守UICollectionView的代理协议
extension BaseAnchorViewController : UICollectionViewDelegate {
   @objc func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 1.取出对应的主播信息
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        // 2.判断是秀场房间&普通房间
        anchor.isVertical == 0 ? pushNormalRoomVc() : presentShowRoomVc()
    }
    
    private func presentShowRoomVc() {
        // 1.创建ShowRoomVc
        let showRoomVc = RoomShowViewController()
        
        // 2.以Modal方式弹出
        present(showRoomVc, animated: true, completion: nil)
    }
    
    private func pushNormalRoomVc() {
        // 1.创建NormalRoomVc
        let normalRoomVc = RoomNormalViewController()
        
        // 2.以Push方式弹出
        navigationController?.pushViewController(normalRoomVc, animated: true)
    }
}

