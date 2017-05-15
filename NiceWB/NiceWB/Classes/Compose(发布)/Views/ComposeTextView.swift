//
//  ComposeTextView.swift
//  NiceWB
//
//  Created by HongWei on 2017/5/15.
//  Copyright © 2017年 HongWei. All rights reserved.
//

import UIKit

class ComposeTextView: UITextView {
    
    lazy var placeholder : UILabel = UILabel()
    
    //规范
    //如果是添加子控件用这个
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupContent()
    }
    
    //如果是对子控件做一些初始化设置用这个
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
}

extension ComposeTextView {
    func setupContent(){
        
        addSubview(placeholder)
        
        //设置位置约束
        placeholder.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(3)
            make.top.equalTo(self).offset(5)
        }
        
        placeholder.text = "分享微博。。。"
        placeholder.textColor = UIColor.lightGray
        placeholder.font = UIFont.boldSystemFont(ofSize: 13)
        
        
    }
}

extension UITextViewDelegate {
}






