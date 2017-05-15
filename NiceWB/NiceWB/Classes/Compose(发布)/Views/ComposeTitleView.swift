//
//  ComposeTitleView.swift
//  NiceWB
//
//  Created by HongWei on 2017/5/15.
//  Copyright © 2017年 HongWei. All rights reserved.
//

import UIKit


class ComposeTitleView: UIView {

    //懒加载两个label
    lazy var title : UILabel = UILabel()
    lazy var screenName : UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ComposeTitleView {
    func setupLabels() {
        
        addSubview(title)
        addSubview(screenName)
        
        title.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }
        
        screenName.snp.makeConstraints { (make) in
            make.centerX.equalTo(title.snp.centerX)
            make.top.equalTo(title.snp.bottom).offset(3)
        }
        
        //设置文字
        title.font = UIFont.boldSystemFont(ofSize: 15)
        screenName.font = UIFont.boldSystemFont(ofSize: 13)
        screenName.textColor = UIColor.orange
        
        title.text = "发微博"
        screenName.text = UserAccountViewModel.shareInstance.account?.screen_name
    }
}
