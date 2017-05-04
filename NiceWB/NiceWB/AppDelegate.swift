//
//  AppDelegate.swift
//  NiceWB
//
//  Created by HongWei on 2017/3/22.
//  Copyright © 2017年 HongWei. All rights reserved.
//随便修改一点注释 经理

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var rootVC : UIViewController?{
        let login = UserAccountViewModel.shareInstance.isLogin
        return login ? (WelcomeViewController()) : (UIStoryboard.init(name:"Main", bundle: nil).instantiateInitialViewController())
    }
    
    let tColor = UIColor.orange

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //设置全局颜色
        UITabBar.appearance().tintColor = tColor
        UINavigationBar.appearance().tintColor = tColor
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
//        print("accessToken:\(UserAccountViewModel.shareInstance.account?.access_token)")
        let createAtStr = "Thu Apr 06 14:04:02 +0800 2017"
        
        let fmt = DateFormatter()
        fmt.dateFormat = "EEE MM DD HH:MM:SS Z YYYY"
        fmt.locale = Locale(identifier: "en")
        
        let createDate =  fmt.date(from: createAtStr)
        
        let nowDate = Date()
        
        print("上次时间：\(createDate!)当前时间：\(nowDate)")
        
        
        
        
        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

