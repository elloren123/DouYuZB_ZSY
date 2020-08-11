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

private let kBueautifulItemH : CGFloat = kItemW * 4 / 3
private let kCycleViewH : CGFloat = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

class RecommendViewController: BaseAnchorViewController {
    //MARK: - 懒加载
    private lazy var recommentVM:RecommentViewModel = RecommentViewModel()

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
    override func setupUI(){
        super.setupUI()
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - 请求数据
extension RecommendViewController {
    func loadData() {
        //请求推荐数据
        baseVM = recommentVM
        recommentVM.requestData {[unowned self] in
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
            
            self.removeImgV()
        }
        //请求轮播数据
        recommentVM.reloadCycleData {
            self.cycleView.cycleModels = self.recommentVM.cycleModels
        }
        
    }
    
}


//MARK: - UICollectionViewDelegate/UICollectionViewDelegateFlowLayout
extension RecommendViewController:UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kBueautifulItemH)
        }else{
            return CGSize(width: kItemW, height: kNormalItemH)
        }
    }
}

//MARK: - 滑动通知,nav隐藏/显示
extension RecommendViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //偏移量
        let offsetY = scrollView.contentOffset.y
        //头部已经设置有偏移量,所以用0 也可以
        if  offsetY > 0 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNavigationHiddenNofitication), object: nil, userInfo: ["navHidden":"true"])
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNavigationHiddenNofitication), object: nil, userInfo: ["navHidden":"false"])
            
        }
        
    }
    
}
