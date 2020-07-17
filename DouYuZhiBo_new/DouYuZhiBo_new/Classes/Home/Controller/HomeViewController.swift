//
//  HomeViewController.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/17.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

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
        //设置导航栏
       setNavigationBar()
        
    }
    
    private func setNavigationBar(){
        //左侧item
       let btn = UIButton()
        btn.setImage(UIImage.init(named: "logo"), for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        //rig item
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem.init(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
//            UIBarButtonItem.createItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        
        let searchItem = UIBarButtonItem.init(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
            //UIBarButtonItem.createItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        
        let qrcodeItem = UIBarButtonItem.init(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
            //UIBarButtonItem.createItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
}