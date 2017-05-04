//
//  HomeCollectionView.swift
//  NiceWB
//
//  Created by HongWei on 2017/4/11.
//  Copyright © 2017年 HongWei. All rights reserved.
//

import UIKit

class HomeCollectionView: UICollectionView {

    // MARK:- nib 属性
    var picUrls : [URL] = [URL](){
        didSet{
            reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dataSource = self
        delegate = self
    }
}

extension HomeCollectionView : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension HomeCollectionView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = dequeueReusableCell(withReuseIdentifier: "PicCell", for: indexPath) as! picCollectionViewCell
        
        cell.picUrl = picUrls[indexPath.item]
        
        return cell
    }
}


class picCollectionViewCell: UICollectionViewCell {
    
    var picUrl : URL?{
        didSet{
            iconView.sd_setImage(with: picUrl, placeholderImage: UIImage(named: "empty_picture"))
        }
    }
    // MARK:- 控件属性
    @IBOutlet weak var iconView: UIImageView!
}







