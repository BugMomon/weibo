//
//  VisitorView.swift
//  NiceWB
//
//  Created by HongWei on 2017/3/23.
//  Copyright © 2017年 HongWei. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    //创建个类方法构造xil视图
    class func addVisitorView() -> VisitorView{
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as! VisitorView
        
    }

    // MARK:- 控件属性
    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var login: UIButton!
    
    // MARK:- 创建一个给每个视图控制器自定义自己的访客视图
    func setupVisitorViewInfo(iconName:String,titleName:String) {
        iconView.image = UIImage(named:iconName)
        self.tipLabel.text = titleName
        rotationView.isHidden = true
    }
    // MARK:- 创建一个旋转动画
     func addRotationAnimation() {
        let rotation = CABasicAnimation(keyPath:"transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = M_PI*2
        rotation.repeatCount = MAXFLOAT
        rotation.isRemovedOnCompletion = false
        rotation.duration = 6.0
        rotationView.layer.add(rotation, forKey:nil)
    }

}
