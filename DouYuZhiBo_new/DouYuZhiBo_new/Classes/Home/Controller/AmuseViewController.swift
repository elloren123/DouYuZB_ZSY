//
//  AmuseViewController.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/23.
//  Copyright © 2020 LEPU. All rights reserved.
/*
 娱乐
 */

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - kItemMargin * 3)/2
private let kNormalItemH : CGFloat = kItemW * 3 / 4
private let kHeaderH : CGFloat = 50
private let kTopMenuH :CGFloat = 200

private let kNormalCellID = "RecommendVCkNormalCellID"
private let kBueautifulCellID = "RecommendVCkBueautifulCellID"
private let kNormalHeaderID = "RecommendVCkNormalHeaderID"

class AmuseViewController: UIViewController {

    //MARK: - 懒加载
    fileprivate lazy var amuseVM:AmuseViewModel = AmuseViewModel();
    
    fileprivate lazy var collectionView:UICollectionView = { [unowned self] in
            //创建布局
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
            layout.minimumLineSpacing = 1 //应该给0,给你是方便查看
            layout.minimumInteritemSpacing = kItemMargin //这里设置一个最新内边距 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
            layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
            
            //创建collectionview

            let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
            collectionView.backgroundColor = UIColor.white
            collectionView.dataSource = self
//            collectionView.delegate = self
            //给collectionView添加约束,让其随着父控件拉伸
            collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
            
            //注册cell
            collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
           
            //注册Header-->XIB
            collectionView.register(UINib(nibName: "RecommentCollectionHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kNormalHeaderID)
            
            return collectionView
        }()
    
    fileprivate lazy var topMenuView:AmuseMenuView = {
        let topView = AmuseMenuView.amuseMenuView()
        topView.frame = CGRect(x: 0, y: -kTopMenuH, width: kScreenW, height: kTopMenuH)
        return topView
    }()
    
    //MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        reloadData()
        
        
    }
    
}

//MARK: - 设置UI
extension AmuseViewController {
    func setupUI() {
        view.addSubview(collectionView)
        
        collectionView.addSubview(topMenuView)
        
        collectionView.contentInset = UIEdgeInsets(top: kTopMenuH, left: 0, bottom: 0, right: 0)
        
    }
}

//MARK: - 加载数据源
extension AmuseViewController {
    func reloadData(){
        amuseVM.reloadData {
            
            self.collectionView.reloadData()
            
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.topMenuView.groups = tempGroups
            
        }
        
    }
}


extension AmuseViewController:UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return amuseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return amuseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
        cell.anchor = amuseVM.anchorGroups[indexPath.section].anchors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kNormalHeaderID, for: indexPath) as! RecommentCollectionHeadView
        headerView.group = amuseVM.anchorGroups[indexPath.section]
        return headerView
    }
    
    
}
