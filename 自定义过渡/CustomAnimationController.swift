//
//  CustomAnimationController.swift
//  自定义过渡
//
//  Created by FunctionMaker on 16/9/23.
//  Copyright © 2016年 FunctionMaker. All rights reserved.
//

import UIKit

class CustomAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    let isPresenting: Bool
    let duration: NSTimeInterval = 0.5
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
         
        super.init()
    }
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            animatePresentationWithTransitionContext(transitionContext)
        } else {
            animateDismissalWithTransitionContext(transitionContext)
        }
    }
    
    func animatePresentationWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        let presentController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let presentControllerView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let containerView = transitionContext.containerView()!
        
        
        presentControllerView.frame = transitionContext.finalFrameForViewController(presentController)
        presentControllerView.frame.origin.y = containerView.bounds.size.height
        
        containerView.addSubview(presentControllerView)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
            presentControllerView.center.y = containerView.bounds.size.height / 2
        }) { (completed: Bool) in
                transitionContext.completeTransition(completed)
        }
    }
    
    func animateDismissalWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        let presentControllerView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let containerView = transitionContext.containerView()!
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
            presentControllerView.frame.origin.y = containerView.bounds.size.height
        }) { (completed: Bool) in
            transitionContext.completeTransition(completed)
        }
    }
}
