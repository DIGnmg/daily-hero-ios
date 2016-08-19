//
//  ComicZoomPresentAnimationController.swift
//  Marvel Explorer
//
//  Created by Nathanael Gethers on 7/8/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit

class ComicZoomPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    var originFrame = CGRectZero
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey), let containerView = transitionContext.containerView(),
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
            return
        }
        
        let initFrame = originFrame
        let finalFrame = transitionContext.finalFrameForViewController(toVC)
        
        let snapshot = toVC.view.snapshotViewAfterScreenUpdates(true)
        
        snapshot.frame = initFrame
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)
        toVC.view.hidden = true
        
//        self.perspectiveTransformForContainerView(containerView)
        
//        snapshot.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2), 0.0, 1.0, 0.0)

//        Animation
        
        let duration = transitionDuration(transitionContext)
        
        UIView.animateKeyframesWithDuration(duration, delay: 0, options: .CalculationModeCubic, animations: {
//            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1/3, animations: {
//                fromVC.view.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_2), 0.0, 1.0, 0.0)
//            })
//
//            UIView.addKeyframeWithRelativeStartTime(1/3, relativeDuration: 1/3, animations: {
//                snapshot.layer.transform = CATransform3DMakeRotation(CGFloat(0.0), 0.0, 1.0, 0.0)
//            })
//
//            UIView.addKeyframeWithRelativeStartTime(2/3, relativeDuration: 1/3, animations: {
//                snapshot.frame = finalFrame
//            })
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1/3, animations: {
                snapshot.frame = finalFrame
            })
        }) { _ in
            toVC.view.hidden = false
            snapshot.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
    
    func perspectiveTransformForContainerView(containerView: UIView) {
        var transform = CATransform3DIdentity
        transform.m34 = -0.002
        containerView.layer.sublayerTransform = transform
    }

}
