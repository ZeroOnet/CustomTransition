//
//  CustomPresentationController.swift
//  自定义过渡
//
//  Created by FunctionMaker on 16/9/23.
//  Copyright © 2016年 FunctionMaker. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController {
    
    //lazy: when the var value isn't equal to nil, directly return current value
    lazy var dismissView: UIView = {
        let view = UIView(frame: self.containerView!.bounds)
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.alpha = 0.0
        
        return view
    }()
    
    //When a view controller is about to be presented, UIKit calls the presentation controller’s presentationTransitionWillBegin() method.
    override func presentationTransitionWillBegin() {
        dismissView.frame = self.containerView!.bounds
        dismissView.alpha = 0.0
        
        self.containerView!.addSubview(dismissView)
        self.containerView!.addSubview(self.presentedView()!)
        
        let transitionCoordinator = self.presentedViewController.transitionCoordinator()!
        transitionCoordinator.animateAlongsideTransition({ (context: UIViewControllerTransitionCoordinatorContext) in
            self.dismissView.alpha = 1.0
            }, completion: nil)
    }
    
    //At the end of the presentation phase, UIKit calls the presentationTransitionDidEnd(_:) method to let you know that the transition finished.
    override func presentationTransitionDidEnd(completed: Bool) {
        if !completed {
            dismissView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        let transitionCoordinator = self.presentedViewController.transitionCoordinator()!
        transitionCoordinator.animateAlongsideTransition({ (context: UIViewControllerTransitionCoordinatorContext) in
            self.dismissView.alpha = 0.0
            }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        if completed {
            dismissView.removeFromSuperview()
        }
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        var frame = self.containerView!.bounds
        frame = CGRectInset(frame, 50.0, 200.0)
        
        return frame
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        print("rotate")
        coordinator.animateAlongsideTransition({ (context: UIViewControllerTransitionCoordinatorContext) in
            self.dismissView.frame = self.containerView!.bounds
            }, completion: nil)
    }
}
