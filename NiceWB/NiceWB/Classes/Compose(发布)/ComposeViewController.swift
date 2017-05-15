//
//  ComposeViewController.swift
//  NiceWB
//
//  Created by HongWei on 2017/5/15.
//  Copyright © 2017年 HongWei. All rights reserved.
//


import UIKit

class ComposeViewController: UIViewController {
    
    lazy var composeTitle : ComposeTitleView = ComposeTitleView()
    
    @IBOutlet weak var textView: ComposeTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //在页面展示完成后执行设置
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    func hahah() {
        dismiss(animated: true, completion: nil)
    }
}

extension ComposeViewController {
    func setupView(){
        //        view.backgroundColor = .green
        //        title = "发布"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(ComposeViewController.hahah))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "发送", style: .plain, target: self, action: #selector(ComposeViewController.hahah))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        composeTitle.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        navigationItem.titleView = composeTitle
        
    }
}
