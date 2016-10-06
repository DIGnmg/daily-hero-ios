//
//  ZoomDismissAnimationController.swift
//  Marvel Explorer
//
//  Created by Nathanael Gethers on 7/19/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit

class ZoomDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    var destinationFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        let finalFrame = destinationFrame
        let snapshot = fromVC?.view.snapshotView(afterScreenUpdates: false)
        
        containerView.addSubview((toVC?.view)!)
        containerView.addSubview(snapshot!)
        fromVC?.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3, animations: {
                snapshot?.frame = finalFrame
                fromVC?.view.alpha = 0.0
            })
            
            
        }) { _ in
            fromVC?.view.isHidden = false
            snapshot?.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

}
