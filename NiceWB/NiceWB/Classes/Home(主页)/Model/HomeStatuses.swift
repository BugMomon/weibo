//
//  HomeStatuses.swift
//  NiceWB
//
//  Created by HongWei on 2017/4/7.
//  Copyright © 2017年 HongWei. All rights reserved.
//

import UIKit

class HomeStatuses: NSObject {
    
    var mid : Int = 0  //微博MID
    var created_at : String?  //微博创建时间
          var text : String? //微博内容
    //微博来源  <a href=\"http://app.weibo.com/t/feed/6vtZb0\" rel=\"nofollow\">微博 weibo.com</a>
    var source : String?
    var user : UserData?
    var pic_urls : [[String : String]]?
    
    //转发微博
    var retweeted_status : HomeStatuses?
    
    //创建构造函数
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        if let userData = dict["user"] as? [String : AnyObject] {
            user = UserData(dict: userData)
        }
        //解析转发微博数据
        if let retweeted_status = dict["retweeted_status"] as? [String : AnyObject] {
            self.retweeted_status = HomeStatuses(dict: retweeted_status)
        }
    }
    
    //有些属性不用，所以要执行以下方法
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override var description : String {
        return dictionaryWithValues(forKeys: ["mid","created_at","text","source","pic_urls"]).description
    }
}
