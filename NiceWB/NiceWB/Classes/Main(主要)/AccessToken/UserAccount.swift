//
//  UserAccount.swift
//  NiceWB
//
//  Created by HongWei on 2017/3/31.
//  Copyright © 2017年 HongWei. All rights reserved.
//

import UIKit

class UserAccount: NSObject ,NSCoding{
   
    //授权
    var access_token :String?
    //用户ID
    var uid : String?
    //过期剩余秒数
    var expires_in : TimeInterval = 0.0{
        didSet{
            expires_date = NSDate.init(timeIntervalSinceNow: expires_in + (8 * 60 * 60))//在后面加上东八区的时间
        }
    }
    //过期时间
    var expires_date : NSDate?
    //用户昵称
    var screen_name : String?
    //用户头像地址
    var avatar_large : String?
    
//    override init() {
//        super.init()
//    }
    
    init(dict : [String : AnyObject]){
        super.init()
        setValuesForKeys(dict)
    }
    
    //重写这个方法是为了防止模型转换时缺少的key
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    //重写discripsion属性
    override var description: String{
        return dictionaryWithValues(forKeys: ["access_token","uid","expires_date","screen_name","avatar_large"]).description
    }
    
    // MARK:- 归档解档
    //解档方法
    required  init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? NSDate
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        uid = aDecoder.decodeObject(forKey: "uid") as? String
    }
    
    //归档方法
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(screen_name, forKey: "screen_name")
        aCoder.encode(avatar_large, forKey: "avatar_large")
    }    
}






