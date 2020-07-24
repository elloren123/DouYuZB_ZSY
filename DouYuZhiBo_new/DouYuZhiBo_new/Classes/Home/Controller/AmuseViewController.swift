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

private let kTopMenuH :CGFloat = 200

class AmuseViewController: BaseAnchorViewController {

    //MARK: - 懒加载
    fileprivate lazy var amuseVM:AmuseViewModel = AmuseViewModel()

    fileprivate lazy var topMenuView:AmuseMenuView = {
        let topView = AmuseMenuView.amuseMenuView()
        topView.frame = CGRect(x: 0, y: -kTopMenuH, width: kScreenW, height: kTopMenuH)
        return topView
    }()
    
    //MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        reloadMessage()
    }
    
}

//MARK: - 设置UI
extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(topMenuView)
        collectionView.contentInset = UIEdgeInsets(top: kTopMenuH, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - 加载数据源
extension AmuseViewController {
     func reloadMessage(){
        baseVM = amuseVM
        amuseVM.reloadAmuseData {
            self.collectionView.reloadData()
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.topMenuView.groups = tempGroups
        }

    }
}
