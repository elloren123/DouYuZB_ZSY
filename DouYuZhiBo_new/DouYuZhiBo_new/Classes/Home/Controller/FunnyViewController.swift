//
//  FunnyViewController.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/24.
//  Copyright © 2020 LEPU. All rights reserved.
/*
 趣玩
 */

import UIKit

private let topMarginH :CGFloat = 15

class FunnyViewController: BaseAnchorViewController {

    //MARK: - 懒加载
        private lazy var recommentVM:FunnyViewModel = FunnyViewModel()
    //对返回数据的加工
        lazy var anchorGroupsNew : [AnchorGroup] = [AnchorGroup]()
    
    //MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        loadData()
    }

}

//MARK: - 设置UI界面
extension FunnyViewController {
    override func setupUI(){
        super.setupUI()
        let layer = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layer.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: topMarginH, left: 0, bottom: 0, right: 0)
    }
    
}

//MARK: - 请求数据
extension FunnyViewController {
    func loadData() {
        //请求推荐数据
        baseVM = recommentVM
        recommentVM.funnyReloadData {[unowned self] in
            //这里的数据源不对,需要整合成一组;
            let model : AnchorGroup = AnchorGroup()
            for AnchorModel in self.recommentVM.anchorGroups {
                let dataArray:[RoomAnchorModel]? = AnchorModel.anchors
                guard dataArray != nil else{
                    return
                }
                for diction in dataArray! {
                    model.anchors.append(diction)
                }
            }
            self.anchorGroupsNew.append(model)
            self.collectionView.reloadData()
        }
    }
}
