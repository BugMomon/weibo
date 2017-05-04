//
//  HomeViewCell.swift
//  NiceWB
//
//  Created by HongWei on 2017/4/10.
//  Copyright © 2017年 HongWei. All rights reserved.
//

import UIKit

private let edgeMargin : CGFloat = 15 //屏幕两边的空隙
private let middleMargin : CGFloat = 10 //图片中间的间隔

class HomeViewCell: UITableViewCell {

    // MARK:- 控件属性
    @IBOutlet weak var iconview: UIImageView!
    @IBOutlet weak var vipTypeView: UIImageView!
    @IBOutlet weak var vipLevel: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var picView: HomeCollectionView!
    @IBOutlet weak var retweeted_text: UILabel!
    @IBOutlet weak var backGroudView: UIView!
    
    
    
    // MARK:- 约束属性
    @IBOutlet weak var contentCons: NSLayoutConstraint! //内容的宽度约束
    
    // MARK:- 图片展示控件collection view的宽高约束属性
    @IBOutlet weak var picViewWidth: NSLayoutConstraint!
    @IBOutlet weak var picViewHeight: NSLayoutConstraint!
    @IBOutlet weak var picBottomCons: NSLayoutConstraint!
    
    
    
    
    var viewModel : HomeViewModel? {
        didSet{
            guard let viewModel = viewModel else{
                return
            }

            //设置头像
            iconview.sd_setImage(with: viewModel.headImageUrl, placeholderImage: UIImage(named: "avatar_default_small"))
            //设置有没有加v
            vipTypeView.image = viewModel.verifiedImage
            //设置vip等级多少
            vipLevel.image = viewModel.vipLevelImage
            //设置用户名称
            userName.text = viewModel.homeStatuses?.user?.screen_name
            //设置发布时间
            time.text = viewModel.created_time
            //设置微博来源
            source.text = viewModel.sourceText
            //设置微博内容
            content.text = viewModel.homeStatuses?.text
            //给用户名设置颜色
            userName.textColor =  viewModel.vipLevelImage == nil ? UIColor.orange : UIColor.black
            
            //计算图片展示界面的大小
            let picViewWH = computePicViewSize(picCount: (viewModel.picUrls?.count) ?? 0)
            picViewWidth.constant = picViewWH.width
            picViewHeight.constant = picViewWH.height
            
            picView.picUrls = viewModel.picUrls!
            
            //转发微博
            //1.转发的微博正文
            if let retweeted_text_str = viewModel.homeStatuses?.retweeted_status?.text,let addName = viewModel.homeStatuses?.user?.screen_name {
                backGroudView.isHidden = false
                retweeted_text.text = "@\(retweeted_text_str + addName)"
            }else{
                backGroudView.isHidden = true
                retweeted_text.text = nil
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置约束属性 
        contentCons.constant = UIScreen.main.bounds.width - edgeMargin*2
        
        //设置图片布局
        let layout = picView.collectionViewLayout as! UICollectionViewFlowLayout
        let imgWH = (UIScreen.main.bounds.width - (edgeMargin+middleMargin) * 2)/3
        layout.itemSize = CGSize(width: imgWH, height: imgWH)
    }
}

extension HomeViewCell{
    func computePicViewSize(picCount : Int) -> CGSize {
        //如果没有图片
        if picCount == 0 {
            picBottomCons.constant = 0
            return .zero
        }
        picBottomCons.constant = 5
        let imgWH = (UIScreen.main.bounds.width - (edgeMargin+middleMargin) * 2)/3
        let layout = picView.collectionViewLayout as! UICollectionViewFlowLayout

        //如果一张图片
        if picCount == 1 {

            let urlSting = viewModel?.picUrls?.last?.absoluteString
            
            if let singerImage  =  SDWebImageManager.shared().imageCache.imageFromDiskCache(forKey: urlSting){
                let w = singerImage.size.width * 2
                let h = singerImage.size.height * 2
                layout.itemSize = CGSize(width: w, height: h)
                return CGSize(width: w, height: h)
            }
        }
        layout.itemSize = CGSize(width: imgWH, height: imgWH)

        //如果是4张图片
        if picCount == 4 {
            let w = imgWH*2+middleMargin
            return CGSize(width: w, height: w)
        }
        
        //如果是其他数量照片
        //根据图片数计算出行数
        let row = CGFloat((picCount - 1)/3+1)
        let w = UIScreen.main.bounds.width - edgeMargin*2
        let h = imgWH*row + (row-1)*middleMargin
        return CGSize(width: w, height: h)
        
    }
}
















