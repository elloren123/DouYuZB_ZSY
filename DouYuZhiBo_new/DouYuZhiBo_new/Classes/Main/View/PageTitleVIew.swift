//
//  PageTitleVIew.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/17.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

private let kScrollLineH:CGFloat = 2

class PageTitleVIew: UIView {
    
    //MARK: - 定义数组
    private var titles:[String]
   
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
