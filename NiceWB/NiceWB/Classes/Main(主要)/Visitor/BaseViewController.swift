//
//  BaseViewController.swift
//  NiceWB
//
//  Created by HongWei on 2017/3/23.
//  Copyright © 2017年 HongWei. All rights reserved.
//基础类

import UIKit


class BaseViewController: UITableViewController {

    //创建访客视图
    lazy var visitroView : VisitorView  = VisitorView.addVisitorView()
    
    //创建是否登录属性
    var islogin = false
    //如果登录就重载loadview方法，如果未登录就添加显示访客视图
    
    override func loadView() {
        
//        print("base1:\(UserAccountViewModel.shareInstance.account)")
        islogin = UserAccountViewModel.shareInstance.isLogin
        
        islogin ? super.loadView() : addWelComeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
              setupNavigationItems()
    }
}

//extension BaseViewController{
//    // MARK:- 获得
//    func checkArchiverState()->(Bool){
//        //1.获取沙盒路径
//        let Path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
//        //2.拼接一个要保存的文件名
//        let accountPath = (Path as NSString).appendingPathComponent("accout.plist")
//        
//        let account =  NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
//        
//        if account == nil {
//            return false
//        }
//        //两次可选绑定
//        if let account = account{
//            if let expires_date = account.expires_date{
//                //判断时间升序降序
//               if expires_date.compare(Date()) == ComparisonResult.orderedDescending{
//                  return true
//                }
//            }
//            
//        }
//        return false
//    }
//}

// MARK:- UI设置
extension BaseViewController{
    // MARK:- 显示访客视图
    func addWelComeView() {
        view = visitroView

        //给visitroView的按钮添加2个点击事件
        visitroView.register.addTarget(self, action:#selector(registerClick(btn:)), for: .touchUpInside)
        
        visitroView.login.addTarget(self, action:#selector(loginClick(btn:)), for: .touchUpInside)
    }
    
    // MARK:- 设置导航栏按钮
    func setupNavigationItems() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "注册",
                                                                 style:.plain,
                                                                 target: self,
                                                                 action:#selector(registerClick(btn:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "登录",
                                                                 style:.plain,
                                                                 target: self,
                                                                 action:#selector(loginClick(btn:)))
    }
}

// MARK:- 事件监听
extension BaseViewController{
   func registerClick(btn:UIButton) {
        print("register")
    }
    
    func loginClick(btn:UIButton) {
        print("login")
        //创建授权控制器
        let atVc : AccessTokenViewController = AccessTokenViewController()
        //包装导航控制器
        let atNav = UINavigationController(rootViewController: atVc)
        //弹出
        self.present(atNav, animated: true, completion: nil)
        
    }
}







