//
//  AmuseMenuView.swift
//  DouYuZhiBo_new
//
//  Created by LEPU on 2020/7/23.
//  Copyright © 2020 LEPU. All rights reserved.
//

import UIKit

private let kMenuCellID = "kMenuCellID"

class AmuseMenuView: UIView {

    
    
    //MARK: - 控件属性
    var groups : [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    /*
     这里老是写成 class 方法 0.0
     override class func awakeFromNib()
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "AmuseMenuCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        print(collectionView.bounds.size)
        layout.itemSize = collectionView.bounds.size


    }
    
    
}

//MARK: - 快速创建
extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
    
}


//MARK: - UICollectionViewDataSource
extension AmuseMenuView :UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil {
            return 0
        }
        pageControl.numberOfPages = ( groups!.count  - 1 ) / 8 + 1
        return ( groups!.count  - 1 ) / 8 + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! AmuseMenuCell
        
        let startCount = indexPath.row * 8
        var endCount = startCount + 7
        if endCount > groups!.count - 1 {
            endCount = groups!.count - 1
        }
        cell.anchorGroup = Array(groups![startCount...endCount])
        return cell
    }

}

extension AmuseMenuView :UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width / 2
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width)
        
    }
}
