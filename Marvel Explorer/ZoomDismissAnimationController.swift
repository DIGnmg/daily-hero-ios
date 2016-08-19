//
//  ZoomDismissAnimationController.swift
//  Marvel Explorer
//
//  Created by Nathanael Gethers on 7/19/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit

class ZoomDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    var destinationFrame = CGRectZero
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let containerView = transitionContext.containerView(),
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        else {
            return
        }
        
        let finalFrame = destinationFrame
        let snapshot = fromVC.view.snapshotViewAfterScreenUpdates(false)
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)
        fromVC.view.hidden = true
        
        let duration = transitionDuration(transitionContext)
        
        UIView.animateKeyframesWithDuration(duration, delay: 0, options: .CalculationModeCubic, animations: {
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1/3, animations: {
                snapshot.frame = finalFrame
                fromVC.view.alpha = 0.0
            })
            
            
        }) { _ in
            fromVC.view.hidden = false
            snapshot.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }

}
