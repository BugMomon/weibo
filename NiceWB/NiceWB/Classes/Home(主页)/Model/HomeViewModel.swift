//
//  HomeViewModel.swift
//  NiceWB
//
//  Created by HongWei on 2017/4/10.
//  Copyright © 2017年 HongWei. All rights reserved.
//

import UIKit

class HomeViewModel: NSObject {

    var homeStatuses : HomeStatuses?
    
    //处理数据
    var sourceText : String?
    var created_time : String?
    var verifiedImage : UIImage?        //认证用户类型图片
    var vipLevelImage : UIImage?        //会员等级显示图片
    var headImageUrl : URL?             //用户头像的地址
    var picUrls : [URL]? = [URL]()
    

    init(statuses : HomeStatuses) {
        super.init()

        self.homeStatuses = statuses
        
        //处理时间
        if let created_at = statuses.created_at{
            created_time =  NSDate.createDateString(createAtStr: created_at)
        }
//        <a href="http://app.weibo.com/t/feed/6vtZb0" rel="nofollow">微博 weibo.com</a>
        //处理来源
        if let source = statuses.source, source != "" {
        let startIndex = (source as NSString).range(of: ">").location+1
        let endIndex = (source as NSString).range(of: "</").location
        let length = endIndex - startIndex
        let subText = (source as NSString).substring(with: NSRange.init(location: startIndex, length: length))
            sourceText = "来自："+subText
        }
        
        //新的是否加vip图标
        verifiedImage = UIImage(named: statuses.user?.verified == true ? "avatar_enterprise_vip" : "")
        //老的处理认证类型
//        let verifiedType = statuses.user?.verified_type ?? -1
//        
//        switch verifiedType {
//        case 0:
//            verifiedImage = UIImage(named: "avatar_enterprise_vip")
//        case 2,3,5:
//            verifiedImage = UIImage(named: "avatar_grassroot")
//        case 220:
//            verifiedImage = UIImage(named: "avatar_vip")
//        default:
//            verifiedImage = nil
//        }
        
        //处理认证等级
        let level = statuses.user?.verified_type ?? 0
        if level>0 , level<=6 {
            vipLevelImage = UIImage(named: "common_icon_membership_level\(level)")
        }
      
        //处理用户头像
        let  str = statuses.user?.profile_image_url ?? ""
        headImageUrl = URL(string: str)
        
        //处理配图数据,如果微博正文里没有配图，就在转发配图数据中遍历
        if let picUrlsDic = statuses.pic_urls?.count != 0 ? statuses.pic_urls : statuses.retweeted_status?.pic_urls {
            for dic in picUrlsDic{
                guard let str = dic["thumbnail_pic"] else {
                    continue
                }
                let url = URL(string: str)
                picUrls?.append(url!)
            }
        }
    }
}
