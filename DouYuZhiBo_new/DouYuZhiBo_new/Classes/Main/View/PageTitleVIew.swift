//
//  PageTitleVIew.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/17.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

//class表示这个协议只能被类遵守,这是一个点击事件的协议,给ContentView同步的
protocol PageTitleVIewDelegate:class {
    func pageTitleView(titleView:PageTitleVIew,selectedIndex index:Int)
}


private let kScrollLineH:CGFloat = 2

class PageTitleVIew: UIView {
    
    //MARK: - 定义属性
    private var titles:[String]
    //记录当前选择的label tag
    private var currentIndex:Int = 0
    
    weak var delegate : PageTitleVIewDelegate?
    
    //MARK: - 懒加载属性
    private lazy var titleLabels = [UILabel]()
    
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false //控制是否启用滚动到顶部的手势。
        scrollView.bounces = false //边界回弹
        return scrollView
    }()
    
    private lazy var scrollLine:UIView = {
       let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    //MARK: - 自定义构造函数
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    //这个是swift的语法,自定义了构造函数,必须写如下代码
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - 设置UI界面
extension PageTitleVIew{
    private func setupUI(){
        //1. 添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2. 添加Labels
        setupTitles()
        
        //3. 添加底部line
        setupLines()
    }
    private func setupTitles(){
        let labelW:CGFloat = frame.width/CGFloat(titles.count)
        let labelH:CGFloat = frame.height - kScrollLineH
        let labelY:CGFloat = 0
        for (index,title) in titles.enumerated() {
            //1.创建label
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            let labelX:CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            //2.给label添加手势
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            label.addGestureRecognizer(tap)
            
        }
    }
    
    private func setupLines(){
        //1.添加灰色底线
        let  bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        //2. 添加可滚动的line,其他地方可能用到,这里直接懒加载出来
        scrollView.addSubview(scrollLine)
        guard let firstlabel = titleLabels.first else {return}
        firstlabel.textColor = UIColor.orange
        scrollLine.frame = CGRect(x: firstlabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstlabel.frame.width, height: kScrollLineH)
        
    }
    
}


//MARK: - title点击事件
extension PageTitleVIew {
    //事件需要runtime,桥接到OC使用@objc
    @objc func titleLabelClick(_ tap: UITapGestureRecognizer) {
        //1.找到当前点击的label
        guard let currentLabel = tap.view as? UILabel  else{return}
        currentLabel.textColor = UIColor.orange
        
        //2.获取到之前选择的那个label
        let  previousLabel = titleLabels[currentIndex]
        previousLabel.textColor = UIColor.darkGray
        
        //3.移动 scrollLine
        UIView.animate(withDuration: 0.2, animations: {
            self.scrollLine.frame.origin.x = currentLabel.frame.origin.x
//            self.scrollLine.frame = CGRect(x: currentLabel.frame.origin.x, y: self.scrollLine.frame.origin.y, width: self.scrollLine.frame.width, height: self.scrollLine.frame.height)
        }, completion: nil)
        
        //4. 移动 collectionviewCell-->通过代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentLabel.tag)
        
        //5.保存最新的选择label下标
        currentIndex = currentLabel.tag
     }
    
    
}

