//
//  ComposePicCollectionView.swift
//  NiceWB
//
//  Created by HongWei on 2017/5/17.
//  Copyright © 2017年 HongWei. All rights reserved.
//

import UIKit

//注册cell 的id
private let picCell = "picCell"
//定义一个内边距

class ComposePicCollectionView: UICollectionView {
     let itemMargin = CGFloat(15)

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置collectionView的layout
        //拿到布局,转换成线性布局
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        //得到每个item的宽高
        let itemWH = (UIScreen.main.bounds.width - 4*itemMargin)/3
        //设置
        layout.itemSize = CGSize(width:itemWH, height:itemWH)
        //设置边距
        layout.minimumLineSpacing = itemMargin
        layout.minimumInteritemSpacing = 10
        
        //设置collectionview的内边距，往中间挤
        contentInset = UIEdgeInsetsMake(itemMargin, itemMargin, 0, itemMargin)
        //从xib中注册cell
        register(UINib(nibName:"ComposePicCollectionViewCell",bundle:nil),
                 forCellWithReuseIdentifier: picCell)
        dataSource = self
    }
}

extension ComposePicCollectionView : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: picCell, for: indexPath)
         return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

