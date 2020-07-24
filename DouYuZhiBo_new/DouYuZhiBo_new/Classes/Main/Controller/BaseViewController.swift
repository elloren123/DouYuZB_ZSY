//
//  BaseViewController.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/24.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

//    @IBOutlet weak var imgView: UIImageView!
    
    fileprivate lazy var imgView:UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "img_loading_1"))
        imgView.center = self.view.center
        imgView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        imgView.animationDuration = 0.5
        imgView.animationRepeatCount = LONG_MAX
        /*
         
         问题: imgView 没有显示在视图中间
         原因:父控件进行了拉伸导致的,子控件需要跟随进行拉伸
         
         */
        imgView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        
        return imgView
    }()
    
    //这个imgview 是要覆盖到pageCollectionView上的
    var coverView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(R: 250, G: 250, B: 250)
        view.addSubview(imgView)
        imgView.startAnimating()
        
    }

}

extension BaseViewController {
    @objc func removeImgV(){
        coverView?.isHidden = false
        imgView.stopAnimating()
        imgView.removeFromSuperview()
    }
    
}
