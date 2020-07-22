//
//  RecommentCycleView.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/21.
//  Copyright © 2020 LEPU. All rights reserved.
/*
 推荐的轮播图
 */

import UIKit

private let kRecommentCycleCellID = "kRecommentCycleCellID"

class RecommentCycleView: UIView {
    //MARK: - 控件属性
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    //数据源
    var cycleModels:[RecommentCycleModel]? {
        didSet{
            //刷新
            collectionview.reloadData()
            //设置pageContoller
            pageController.numberOfPages = cycleModels?.count ?? 1
            //设置开始的位置:从左侧的第10组数据开始,这样两边都有数据可以滑动
            let indexP = IndexPath(row: (cycleModels?.count ?? 0)*10, section: 0)
            collectionview.scrollToItem(at: indexP, at: .left, animated: false)
            removeTimer()
            addTimer()
        }
    }
    //定时器,自动滚动
    var cycleTimer: Timer?
    
    
    //MARK: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸,如果不设置,会导致被拉伸
        //也可以通过xib设置 -->具体看笔记
//        autoresizingMask = UIView.AutoresizingMask()
        //去除横竖滚动条-->可以xib
        collectionview.showsVerticalScrollIndicator = false
        collectionview.showsHorizontalScrollIndicator = false
        
        //注册cell
        collectionview.register(UINib(nibName: "RecommentCycleViewCell", bundle: nil), forCellWithReuseIdentifier: kRecommentCycleCellID)
        

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置collectionviewlayout
        let layout = collectionview.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionview.bounds.size
        //以下属性可以xib
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
    }
    

}

//MARK: - 快速创建
extension RecommentCycleView {
    class func recommentCycleView() -> RecommentCycleView {
        return Bundle.main.loadNibNamed("RecommentCycleView", owner: nil, options: nil)?.first as! RecommentCycleView
    }
    
}

//MARK: - UICollectionViewDataSource
extension RecommentCycleView:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //给10000倍的数量,用于轮播;
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommentCycleCellID, for: indexPath) as! RecommentCycleViewCell
        cell.cycleModel = cycleModels?[indexPath.row % (cycleModels?.count ?? 1)]
        return cell
    }
    
}


//MARK: - UICollectionViewDelegate
extension RecommentCycleView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //将要手动移动图片,移除定时器
        removeTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //手动结束,添加定时器
        addTimer()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //计算偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width / 2
        pageController.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
        
    }
}

//MARK: - 定时器
extension RecommentCycleView {
    func addTimer() {
        cycleTimer = Timer(timeInterval: 3, repeats: true, block: { (time) in
            //计算偏移量
            let offsetX = self.collectionview.contentOffset.x
            let nextOffsetX = offsetX + self.collectionview.bounds.width
            //移动到下一个位置
            self.collectionview.setContentOffset(CGPoint(x: nextOffsetX, y: 0), animated: true)
            
        })
        //必须加入到对应的runloop中
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    
    func removeTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
}
