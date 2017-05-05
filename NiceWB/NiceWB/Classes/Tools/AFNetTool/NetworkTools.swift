//
//  NetworkTools.swift
//  NiceWB
//
//  Created by HongWei on 2017/3/30.
//  Copyright © 2017年 HongWei. All rights reserved.
//

import UIKit


enum requestType : String{
    case GET = "GET"
    case POST = "POST"
}

class NetworkTools: AFHTTPSessionManager {
    
    static let shareInstance : NetworkTools = {
        let tools  = NetworkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()
}

// MARK:- 请求首页信息
extension NetworkTools{
    func loadHomeViewData(since_id : Int,max_id : Int, finshed:@escaping (_ result : [[String : AnyObject]]?,_ error : Error?)->()){
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        let access_token = UserAccountViewModel.shareInstance.account?.access_token
        let parameter = ["access_token" : access_token,
                         "since_id" : "\(since_id)",
                         "max_id" : "\(max_id)"]
        request(requestType: .GET, url: url, parameters: parameter as [String : AnyObject]?) { (result, error) in
            
            guard let resultDic = result as? [String : AnyObject] else{
                finshed(nil, error)
                return
            }
            let resultArray = resultDic["statuses"]
            finshed(resultArray as! [[String : AnyObject]]?, error)
        }
    }
}

// MARK:- 请求用户信息
extension NetworkTools{
    func loadUser(userAccount : UserAccount,finshed:@escaping (_ result : [String : AnyObject]?,_ error : Error?)->()){
        let url = "https://api.weibo.com/2/users/show.json"
        let paramet = ["access_token" : userAccount.access_token,
                       "uid" : userAccount.uid,
                       ]
        request(requestType: .GET, url: url, parameters: paramet as [String : AnyObject]?) { (r, e) in
            finshed(r as! [String : AnyObject]?, e)
        }
    }
}

// MARK:- 请求accessToken
extension NetworkTools{
    //请求AccessToken
    
    func loadAccessToken(code : String,finshed: @escaping (_ result : [String : AnyObject]?,_ error : Error?)->()) {
        let url = accessToken_url
        let paramet = ["client_id" : app_key,
                       "client_secret":app_secret,
                       "grant_type" : "authorization_code",
                       "code" : code,
                       "redirect_uri" : redirect_uri
                       ]
        request(requestType: .POST, url: url, parameters: paramet as [String : AnyObject]?) { (result, error) in
            finshed(result as! [String : AnyObject]?, error)
        }
    }
}

// MARK:- 封装请求方法
extension NetworkTools {
    //请求方法
    func request(requestType : requestType,url : String,parameters : [String : AnyObject]?,finished: @escaping (_ result : Any?,_ error : Error?)->()) {
      
        //创建请求成功的闭包
        let success = {(task : URLSessionDataTask, result : Any?) -> Void in
            finished(result, nil)
        }
        //创建失败的闭包
        let failure = {(task : URLSessionDataTask?, error : Error) -> Void in
            finished(nil, error)
}
        if requestType == .GET {
            get(url, parameters: parameters, progress: nil, success: success, failure: failure)
        }else{
            post(url, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
}




