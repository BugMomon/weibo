//
//  MainviewController.swift
//  MomonWB
//
//  Created by HongWei on 2017/3/21.
//  Copyright © 2017年 HongWei. All rights reserved.
//

import UIKit

class MainviewController: UITabBarController {

    // MARK:- 懒加载属性
    lazy var compose : UIButton = UIButton(backImage:"tabbar_compose_button",image:"tabbar_compose_icon_add")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupComposeBtn()
    }
}

// MARK:- 设置UI界面
extension MainviewController{
    //设置发布按钮
    func setupComposeBtn(){
        compose.center = CGPoint(x:tabBar.center.x,y:tabBar.bounds.size.height*0.5)
        compose.addTarget(self, action:#selector(composeClick), for: .touchUpInside)
        self.tabBar.addSubview(compose)
    }
}

// MARK:- 点击事件
extension MainviewController{
    func composeClick(){
        print("woyaodaren")
    }
}
