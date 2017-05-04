//
//  UserAccountViewModel.swift
//  NiceWB
//
//  Created by HongWei on 2017/4/5.
//  Copyright © 2017年 HongWei. All rights reserved.
//

import Foundation

class UserAccountViewModel {
    
    static let  shareInstance : UserAccountViewModel = UserAccountViewModel()
    
    var account : UserAccount?
    
    var isLogin : Bool {
        
        guard let account = account else {
            return false
        }
            if let expires_date = account.expires_date{
                //判断时间升序降序
                if expires_date.compare(Date()) == ComparisonResult.orderedDescending{
                    return true
                }
            }
        return true
    }
    
    var accountPath : String{
        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (accountPath as NSString).appendingPathComponent("account.plist")
    }
    
    init() {
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as! UserAccount?
//        print("viewModel : \(account)")
//        print(accountPath)
     
    }
}
