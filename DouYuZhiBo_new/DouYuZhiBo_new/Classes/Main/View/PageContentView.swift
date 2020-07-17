//
//  PageContentView.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/17.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

private let contentCellID = "contentCellID"

class PageContentView: UIView {

    //MARK: - 自定义属性
    private var childVCs:[UIViewController]
    private var parentVC:UIViewController
    
    //MARK: - 懒加载
    private lazy var collectionVIew:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.isPagingEnabled = true
        collectionV.bounces = false
        collectionV.dataSource = self
        // .self 可以拿到对应的类型
        collectionV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionV
    }()
    
    
    //MARK: - 自定义构造函数
    init(frame: CGRect,chileVCs:[UIViewController],parentVC:UIViewController) {
        self.childVCs = chileVCs
        self.parentVC = parentVC
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - 设置UI界面

extension PageContentView {
    private func setupUI() {
        //1.把所有VC添加到父视图
        for childVC in childVCs{
            parentVC.addChild(childVC)
        }
        
        //2.添加collectionView,在cell中存放控制器view
        addSubview(collectionVIew)
        collectionVIew.frame = bounds
        
        
    }
    
}

//MARK: - collectionView代理

extension PageContentView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        //每次都添加上去,所以要做一个移除操作
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        return cell
    }
}
