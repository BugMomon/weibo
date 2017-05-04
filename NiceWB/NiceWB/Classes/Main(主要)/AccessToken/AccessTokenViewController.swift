//
//  AccessTokenViewController.swift
//  NiceWB
//
//  Created by HongWei on 2017/3/30.
//  Copyright © 2017年 HongWei. All rights reserved.
//

import UIKit

class AccessTokenViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNaviButtons()
        //打开网页
        loadWebViewContent()
    }
}

// MARK:- 1.网页请求到web代理里面拿到加载网页的url截取code
extension AccessTokenViewController{
    func loadWebViewContent() {
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)"
        
        guard let url = NSURL(string:urlString) else {
            return
        }
        
        let request = NSURLRequest(url:url as URL)
        
        webView.loadRequest(request as URLRequest)
    }
}

// MARK:- 2.webView代理方法
extension AccessTokenViewController:UIWebViewDelegate{
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        //获取加载网页的url
        guard let url = request.url else {
            return false
        }
        //把url转成字符串
        let urlString =  url.absoluteString
        
        //判断字符串中有没有"code="这个字符串
        guard urlString.contains("code=") else {
//            print(urlString)
           return true
        }
        //截取
        let str = urlString.components(separatedBy:"code=")
        let code = str.last!
        
        //3.获取到code请求accesstoken
        loadToken(code: code)
        
        return false
    }
}

// MARK:- 使用code交换accesstoken请求数据
extension AccessTokenViewController{
    func loadToken(code : String) {
        NetworkTools.shareInstance.loadAccessToken(code: code) { result,error in
            guard error == nil else{
                print(error!)
                return
            }
            
           guard let dic  = result else{
            return
            }
            //拿到字典数据给对象转换成模型
            let userAccount : UserAccount = UserAccount.init(dict: dic)
            
            //发送网络请求
            NetworkTools.shareInstance.loadUser(userAccount: userAccount, finshed: { (result, error) in
                guard error == nil else{
                    print(error!)
                    return
                }
                //拿到用户信息
                guard let userDict = result else {
                    return
                }

                userAccount.screen_name = userDict["screen_name"] as? String
                userAccount.avatar_large = userDict["avatar_large"] as? String
                print("accessToken:\(userAccount.access_token)")

                //4.归档保存这个模型对象
                self.setupArchive(userAccount: userAccount)
            })
        }
    }
}

// MARK:- 归档
extension AccessTokenViewController{
    func setupArchive(userAccount : UserAccount) {
        //归档
        //1.获取沙盒路径
        //2.拼接一个要保存的文件名
        let accountPath = UserAccountViewModel.shareInstance.accountPath
//        print("路径：plist\(accountPath)")

        //如果想要保存某一个对象，这个对象必须遵守NSCoding协议
        //实现
        //3.保存对象
        NSKeyedArchiver.archiveRootObject(userAccount, toFile: accountPath)
        
//        print("归档后:\(userAccount)")
        //5.给归档的单例再设置一次account值
        UserAccountViewModel.shareInstance.account = userAccount
        
        //4.显示登录成功的欢迎页面
        dismiss(animated: false) {
            UIApplication.shared.keyWindow?.rootViewController? = WelcomeViewController()
        }
    }
}

// MARK:- UI
extension AccessTokenViewController{
    func addNaviButtons(){
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "关闭", style: .plain, target: self, action: #selector(AccessTokenViewController.backClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "填充", style: .plain, target: self, action: #selector(AccessTokenViewController.fullClick))
    }
}

// MARK:-  点击事件
extension AccessTokenViewController{
    func backClick() {
        dismiss(animated: true, completion: nil)
    }
    func fullClick() {
//        print("填充按钮")
        //js代码
        let jsCode = "document.getElementById('userId').value='momon1204@163.com';document.getElementById('passwd').value='benn851204';"
        webView.stringByEvaluatingJavaScript(from: jsCode)
    }
}


