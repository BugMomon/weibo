//
//  TitleViewAnimator.swift
//  NiceWB
//
//  Created by HongWei on 2017/3/28.
//  Copyright © 2017年 HongWei. All rights reserved.
//

import UIKit

class TitleViewAnimator: NSObject {
    var isPresented: Bool = false
    var pvframe : CGRect = .zero
    
    let callBack:((_ presented : Bool)->())?
    //声明的闭包必须有值，所以重写构造方法让其必须传一个闭包过来
    init(callBack:@escaping ((_ presented : Bool)->())) {
        self.callBack = callBack
    }
}

// MARK:- 转场动画的委托代理方法
extension TitleViewAnimator : UIViewControllerTransitioningDelegate{
    
    //改变弹出视图的尺寸
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let  presenVC: PresentationViewController = PresentationViewController(presentedViewController: presented, presenting: presenting)
        
        presenVC.PresentationViewFrame = pvframe
        
        return presenVC
    }
    
    //自定义弹出的动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    //自定义消失的动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}

// MARK:- 自定义动画的委托代理方法
extension TitleViewAnimator : UIViewControllerAnimatedTransitioning{
    //动画执行时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    //自定义内部动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        isPresented == false ? PresentedAnimator(transitionContext: transitionContext):dismisAnimator(transitionContext:transitionContext)
        
        isPresented = !isPresented
        callBack!(isPresented)
        
    }
    
    func PresentedAnimator(transitionContext: UIViewControllerContextTransitioning) {
        //取出toview弹出视图
        let presentedView = transitionContext.view(forKey:.to)!
        
        let cView = transitionContext.containerView
        cView.alpha = 0.0
        
        transitionContext.containerView.addSubview(presentedView)
        presentedView.transform = CGAffineTransform(scaleX: 1,y: 0)
        presentedView.layer.anchorPoint = CGPoint(x:0.5,y:0)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveEaseOut, animations: {
            cView.alpha = 1
            presentedView.transform = .identity
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    
    func dismisAnimator(transitionContext: UIViewControllerContextTransitioning) {
        //取出fromView消失视图
        let closeView = transitionContext.view(forKey: .from)!
        let cView = transitionContext.containerView
        cView.alpha = 1.0

        transitionContext.containerView.addSubview(closeView)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveEaseOut, animations: {
            cView.alpha = 0.0
            closeView.transform = CGAffineTransform(scaleX: 1,y: 0.0001)
        }) { (_) in
            closeView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}

