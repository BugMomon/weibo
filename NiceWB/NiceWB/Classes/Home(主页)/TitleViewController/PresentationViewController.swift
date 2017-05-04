//
//  PresentationView.swift
//  NiceWB
//
//  Created by HongWei on 2017/3/27.
//  Copyright © 2017年 HongWei. All rights reserved.
//弹出视图

import UIKit

class PresentationViewController: UIPresentationController {

    lazy var container : UIView = UIView()
    var PresentationViewFrame : CGRect = .zero
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        presentedView?.frame = PresentationViewFrame
        containerView?.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        setupContainerView()
    }
    
    func setupContainerView(){
        containerView?.insertSubview(container, at: 0)
        container.frame = containerView!.bounds
        
        let tap = UITapGestureRecognizer(target: self, action:#selector(dismissTap))
        container.addGestureRecognizer(tap)
    }
    
    func dismissTap(){
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}


