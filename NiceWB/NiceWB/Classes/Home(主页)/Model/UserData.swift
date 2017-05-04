//
//  UserData.swift
//  NiceWB
//
//  Created by HongWei on 2017/4/7.
//  Copyright © 2017年 HongWei. All rights reserved.
//

import UIKit

class UserData: NSObject {

    var screen_name : String?           //用户昵称
    var profile_image_url : String?     //用户头像地址
    var verified : Bool = false         //认证用户类型是否加v
    var verified_type : Int = -1         //会员等级
    
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {    }
    
    override var description : String{
        return dictionaryWithValues(forKeys: ["screen_name","profile_image_url","verified_type","verified"]).description
    }
}
