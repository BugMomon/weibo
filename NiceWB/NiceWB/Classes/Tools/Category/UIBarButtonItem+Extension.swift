//
//  UIBarButtonItem+Extension.swift
//  NiceWB
//
//  Created by HongWei on 2017/3/24.
//  Copyright © 2017年 HongWei. All rights reserved.
//

import UIKit

extension UIBarButtonItem{

    convenience init(ImageName:String) {
        self.init()
        let btn = UIButton()
        btn.setImage(UIImage(named:ImageName), for: .normal)
        btn.setImage(UIImage(named:ImageName+"_highlighted"), for: .highlighted)
        
        btn.sizeToFit()
        customView = btn
    }
}
