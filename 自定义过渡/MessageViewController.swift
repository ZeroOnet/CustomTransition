//
//  MessageViewController.swift
//  自定义过渡
//
//  Created by FunctionMaker on 16/9/23.
//  Copyright © 2016年 FunctionMaker. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //declare modal presentation style is custom style, otherwise custom style will make conflict to system style
        self.modalPresentationStyle = .Custom
        self.transitioningDelegate = self
    }

    @IBAction func dismissTouched(sender: UIButton) {
        self.dismissViewControllerAnimated(true) { 
            print("dismiss")
        }
    }
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        if presented == self {
            //presented: MessageViewController source: ViewController
            print("presented: \(presented), source:\(source)")

            return CustomPresentationController(presentedViewController: presented, presentingViewController: presenting)
        } else {
            return nil
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if source == presenting {
            print("equal")
        }
        if presented == self {
            print("presented: \(presented)), presenting: \(presenting) source:\(source)")
            
            return CustomAnimationController(isPresenting: true)
        } else {
            return nil
        }
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if dismissed == self {
            //dismissed: MessageViewController
            print("dismissed: \(dismissed)")
            
            return CustomAnimationController(isPresenting: false)
        } else {
            return nil
        }
    }
    
}
