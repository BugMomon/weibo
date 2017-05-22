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
    
    @IBOutlet weak var picPickerH: NSLayoutConstraint!
    @IBOutlet weak var toolBarBottom: NSLayoutConstraint!
    @IBOutlet weak var textView: ComposeTextView!
    
    // MARK:- toolbar的点击事件
    @IBAction func picPickerBtnClick(_ sender: Any) {
        
        textView.resignFirstResponder()
        picPickerH.constant = UIScreen.main.bounds.height * 0.6
        UIView.animate(withDuration:0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillChangeFrame), name: .UIKeyboardWillChangeFrame, object: nil)
    }
    
    //在页面展示完成后执行设置
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    func cancelCompose() {
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ComposeViewController {
    func setupView(){
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(ComposeViewController.cancelCompose))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "发送", style: .plain, target: self, action: #selector(ComposeViewController.cancelCompose))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        composeTitle.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        navigationItem.titleView = composeTitle
    }
    
    // MARK:-监听事件
    func KeyboardWillChangeFrame(noti : Notification) {
        //获取弹出键盘的持续时间
        let d = noti.userInfo?[UIKeyboardAnimationDurationUserInfoKey]as! TimeInterval
        
        //让工具栏一起弹出
        let endFrame = noti.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue
        let toolbarMargin = endFrame.cgRectValue.origin.y
        
        toolBarBottom.constant = UIScreen.main.bounds.height -  toolbarMargin
        //执行动画
        UIView.animate(withDuration: d ) {
            self.view.layoutIfNeeded()
        }
        
    }
}


// MARK:- textView代理方法
extension ComposeViewController : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
    }
    func textViewDidChange(_ textView: UITextView) {
        print("开始输入")
        if (textView.hasText == true) {
            self.textView.placeholder.isHidden = true
            navigationItem.rightBarButtonItem?.isEnabled = true
        }else{
            self.textView.placeholder.isHidden = false
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
//        self.textView.placeholder.isHidde = textView.hasText()
    }
}

extension ComposeViewController : UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }
}

