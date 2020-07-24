//
//  PageContentView.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/17.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit


protocol PageContentViewDelegate : class {
    func PageContentViewScroll(contentView:PageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}

private let contentCellID = "contentCellID"

class PageContentView: UIView {

    //MARK: - 自定义属性
    private var childVCs:[UIViewController]
    //weak消除强引用,变成可选类型
    private weak var parentVC:UIViewController?
    //开始滑动的偏移量
    private var startOffsetX:CGFloat = 0.0
    weak var delegate : PageContentViewDelegate?
    //这里设置一个阻止title点击时响应scroll的滑动代理的方法的BOOL
    private var isForbidScrollDelegate:Bool = false
    
    //MARK: - 懒加载
    fileprivate lazy var collectionVIew:UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.isPagingEnabled = true
        collectionV.bounces = false
        collectionV.dataSource = self
        collectionV.delegate = self
        // .self 可以拿到对应的类型
        collectionV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionV
    }()
    
    
    //MARK: - 自定义构造函数
    init(frame: CGRect,chileVCs:[UIViewController],parentVC:UIViewController?) {
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
            parentVC?.addChild(childVC)
        }
        
        //2.添加collectionView,在cell中存放控制器view
        addSubview(collectionVIew)
        collectionVIew.frame = bounds
        
        
    }
    
}

//MARK: - UICollectionViewDataSource代理

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
        print(" 当前被加载的VC ===  \(childVC.self)")
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       //是title点击事件,return
        if isForbidScrollDelegate == true {
            isForbidScrollDelegate = false
            return
            
        }
        
        var progress : CGFloat = 0.0 //滑动比例
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        //判断是左滑是右滑
        if currentOffsetX > startOffsetX {
            //左滑
            //1.比例计算
            let ratio = currentOffsetX / collectionVIew.frame.width
            progress = ratio - floor(ratio) //减去整数部分
            
            //2.
            sourceIndex = Int(currentOffsetX / collectionVIew.frame.width)
            
            //3.
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count{
                targetIndex = childVCs.count - 1
            }
            
            //到1时,要处理,因为系统有默认的一个可超出边界的范围,类似于一个小弹簧一样
            if currentOffsetX - startOffsetX == collectionVIew.frame.width {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{
            //右滑
            //1.
            let ratio = currentOffsetX / collectionVIew.frame.width
            progress = 1 - (ratio - floor(ratio)) //减去整数部分
            
            //2.
            targetIndex = Int(currentOffsetX / collectionVIew.frame.width)
            
            //3.
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }

        }
        
        //把数据传给titleView
        delegate?.PageContentViewScroll(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}

//MARK: - 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex:Int) -> Void {
        //title点击会调用这个方法,所以这里设置禁止代理
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(currentIndex) * collectionVIew.frame.width //计算偏移量
        collectionVIew.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        
    }
}


extension PageContentView {
    func refshUI(){
        collectionVIew.frame = self.bounds
        let layout = collectionVIew.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = self.bounds.size
    }
}
