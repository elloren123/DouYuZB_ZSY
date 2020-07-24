//
//  FunnyViewController.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/24.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - kItemMargin * 3)/2
private let kNormalItemH : CGFloat = kItemW * 3 / 4
private let topMarginH :CGFloat = 15

private let kNormalCellID = "RecommendVCkNormalCellID"


class FunnyViewController: UIViewController {

    //MARK: - 懒加载
        private lazy var recommentVM:FunnyViewModel = FunnyViewModel()
        private lazy var collectionView:UICollectionView = { [unowned self] in
            //创建布局
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
            layout.minimumLineSpacing = 1 //应该给0,给你是方便查看
            layout.minimumInteritemSpacing = kItemMargin //这里设置一个最新内边距 10, 实际上,这里会被分配成30,所以要加内边距
            layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
            
            layout.headerReferenceSize = CGSize.zero
            
            //创建collectionview
            //这里的frame,给的是 self.view.bounds
           
            print(self.view.bounds) //-->在VC内部的这个bounds,在创建时并没有设置,所以会打印成屏幕大小

            let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
            collectionView.backgroundColor = UIColor.white
            collectionView.dataSource = self
//            collectionView.delegate = self
            //给collectionView添加约束,让其随着父控件拉伸
            collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
            
            //注册cell
 
            collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
            
            return collectionView
        }()
    
    //MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        loadData()
    }

}

//MARK: - 设置UI界面
extension FunnyViewController {
    private func setupUI(){
        view.addSubview(collectionView)
        collectionView.contentInset = UIEdgeInsets(top: topMarginH, left: 0, bottom: 0, right: 0)
    }
    
}


//MARK: - 请求数据
extension FunnyViewController {
    func loadData() {
        //请求推荐数据
        recommentVM.reloadData {
            self.collectionView.reloadData()
        }
        
    }
    
}


//MARK: - UICollectionViewDataSource
extension FunnyViewController:UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommentVM.anchorGroups.count //斗鱼的推荐就是12组
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return recommentVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
        cell.anchor = recommentVM.anchorGroups[indexPath.section].anchors[indexPath.row]
        return cell
        
    }
    
  
    
}
