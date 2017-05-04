//
//  UIButton+Extension.swift
//  NiceWB
//
//  Created by HongWei on 2017/3/23.
//  Copyright © 2017年 HongWei. All rights reserved.
//

import UIKit

extension UIButton{
    //创建类方法
//    class func createButton(backImage:String,image:String) ->UIButton{
//        let btn = UIButton()
//        btn.setBackgroundImage(UIImage(named:backImage), for:.normal)
//        btn.setBackgroundImage(UIImage(named:backImage+"_highlighted"), for:.highlighted)
//        btn.setImage(UIImage(named:image), for:.normal)
//        btn.setImage(UIImage(named:image+"_highlighted"), for:.highlighted)
//        btn.sizeToFit()
//    
//        return btn
//    }
    
    //扩展构造方法创建按钮
    convenience init(backImage:String,image:String) {
        self.init()
        //直接set，self都不用写
        setBackgroundImage(UIImage(named:backImage), for:.normal)
        setBackgroundImage(UIImage(named:backImage+"_highlighted"), for:.highlighted)
        setImage(UIImage(named:image), for:.normal)
        setImage(UIImage(named:image+"_highlighted"), for:.highlighted)
        sizeToFit()
    }
}
