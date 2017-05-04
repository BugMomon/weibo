//
//  WelcomeViewController.swift
//  NiceWB
//
//  Created by HongWei on 2017/4/5.
//  Copyright © 2017年 HongWei. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var welcomename: UILabel!
    @IBOutlet weak var iconBottomCons: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //0.设置头像
        let path = UserAccountViewModel.shareInstance.account?.avatar_large
        let userName = UserAccountViewModel.shareInstance.account?.screen_name
        
        let welText =  NSMutableAttributedString(string: "欢迎回来,\(userName!)!")
        print(welText.length)
        //给label添加颜色
        welText.addAttribute(NSForegroundColorAttributeName, value: UIColor.gray, range: NSMakeRange(0, 4))
        welText.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSMakeRange(5, 8))
        welcomename.attributedText = welText
        
//         print("用户照片路径：\(path!)")
        let url = URL(string:path ?? "")
        icon.sd_setImage(with:url, placeholderImage: UIImage(named:"avatar_default_big"))

        print("layout\(iconBottomCons.constant)")
        //1.改变约束的值
        iconBottomCons.constant = UIScreen.main.bounds.height - 200
        
        //执行动画
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity:5.0, options: [], animations: {
            
            self.view.layoutIfNeeded()
            
//           self.icon.center = CGPoint(x: self.icon.center.x, y: self.icon.center.y - 500)
            
        }) { (_) in
            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()
        }
        
    }
}
