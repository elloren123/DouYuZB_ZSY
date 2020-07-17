//
//  HomeViewController.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/17.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

private let kTitleViewH:CGFloat = 40

class HomeViewController: UIViewController {

    //MARK: - 懒加载属性
    //这是一个自己调用的闭包语法
    private lazy var pageTitleView:PageTitleVIew = {
        let titleFrame = CGRect(x: 0, y: CGFloat(kStatusBarH + kNavigationBar), width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titView = PageTitleVIew(frame: titleFrame, titles: titles)
//        titView.backgroundColor = UIColor.purple
        return titView
    }()
    
    private lazy var pageContentView:PageContentView = {[weak self] in
        //frame
        let contentH = kScreenH - kStatusBarH - kNavigationBar - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBar + kTitleViewH, width: kScreenW, height: contentH)
        //子控制器
        var childVCs = [UIViewController]()
        for _ in 0..<4{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(R: CGFloat(arc4random_uniform(255)), G: CGFloat(arc4random_uniform(255)), B: CGFloat(arc4random_uniform(255)))
            childVCs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, chileVCs: childVCs, parentVC: self)
        return contentView
    }()
    
    //MARK: - 系统构造函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI
        setupUI()
        
        
        
    }
    


}
//MARK: - 设置UI界面
//swift通过extension,对HomeViewController的功能模块进行划分;swift的典型做法;
extension HomeViewController {
    private func setupUI(){
        //MARK: - 有导航栏,scrollView会默认添加64的内边距,我们不需要,去除
        automaticallyAdjustsScrollViewInsets = false
        
        //设置导航栏
        setNavigationBar()
        //添加titleVIew
        view.addSubview(pageTitleView)
        //添加contentVIew
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    
    private func setNavigationBar(){
        //左侧item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //rig item
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)

        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
          
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
           
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
}
