//
//  RecommendViewController.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/18.
//  Copyright © 2020 LEPU. All rights reserved.
/**
 推荐
 */

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - kItemMargin * 3)/2
private let kNormalItemH : CGFloat = kItemW * 3 / 4
private let kBueautifulItemH : CGFloat = kItemW * 4 / 3
private let kHeaderH : CGFloat = 50
private let kCycleViewH : CGFloat = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90
private let kNormalCellID = "RecommendVCkNormalCellID"
private let kBueautifulCellID = "RecommendVCkBueautifulCellID"
private let kNormalHeaderID = "RecommendVCkNormalHeaderID"

class RecommendViewController: UIViewController {
    //MARK: - 懒加载
    private lazy var recommentVM:RecommentViewModel = RecommentViewModel()
    private lazy var collectionView:UICollectionView = { [unowned self] in
        //创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 1 //应该给0,给你是方便查看
        layout.minimumInteritemSpacing = kItemMargin //这里设置一个最新内边距 10, 实际上,这里会被分配成30,所以要加内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        
        //创建collectionview
        //这里的frame,给的是 self.view.bounds
       
        print(self.view.bounds) //-->在VC内部的这个bounds,在创建时并没有设置,所以会打印成屏幕大小

        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        //给collectionView添加约束,让其随着父控件拉伸
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        //注册cell
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        //注册普通cell-->XIB
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionBeautifulCell", bundle: nil), forCellWithReuseIdentifier: kBueautifulCellID)
        
        
        //注册Header
//         collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kNormalHeaderID)
        //注册Header-->XIB
        collectionView.register(UINib(nibName: "RecommentCollectionHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kNormalHeaderID)
        
        return collectionView
    }()
    private lazy var cycleView:RecommentCycleView = {
        let cycleV = RecommentCycleView.recommentCycleView()
        cycleV.frame = CGRect(x: 0, y: -(kCycleViewH+kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleV
    }()
    private lazy var gameView:RecommentGameView = {
        let gameV = RecommentGameView.recommentGameView()
        gameV.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameV
    }()
    
    
    //MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        loadData()
    }
    

}

//MARK: - 设置UI界面
extension RecommendViewController {
    private func setupUI(){
        view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
    
}

//MARK: - 请求数据
extension RecommendViewController {
    func loadData() {
        //请求推荐数据
        recommentVM.requestData {
            self.collectionView.reloadData()
            var allAnchorGroups = self.recommentVM.anchorGroups
            //移除第一第二个,从第三个到底12个展示
            allAnchorGroups.removeFirst()
            allAnchorGroups.removeFirst()
            //添加一组,更多
            let moreGroup:AnchorGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            allAnchorGroups.append(moreGroup)
            
            self.gameView.anchorGroup = allAnchorGroups
            
        }
        //请求轮播数据
        recommentVM.reloadCycleData {
            self.cycleView.cycleModels = self.recommentVM.cycleModels
        }
        
    }
    
}


//MARK: - UICollectionViewDataSource
extension RecommendViewController:UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommentVM.anchorGroups.count //斗鱼的推荐就是12组
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return recommentVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kBueautifulCellID, for: indexPath) as! CollectionBeautifulCell
            cell.anchor = recommentVM.anchorGroups[indexPath.section].anchors[indexPath.row]
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
        cell.anchor = recommentVM.anchorGroups[indexPath.section].anchors[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kNormalHeaderID, for: indexPath) as! RecommentCollectionHeadView
        headerView.group = recommentVM.anchorGroups[indexPath.section]
        return headerView
    }
    
}

//MARK: - UICollectionViewDelegate/UICollectionViewDelegateFlowLayout
extension RecommendViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kBueautifulItemH)
        }else{
            return CGSize(width: kItemW, height: kNormalItemH)
        }
    }
    

}
