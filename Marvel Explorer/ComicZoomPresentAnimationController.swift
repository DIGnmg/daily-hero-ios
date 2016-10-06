//
//  ComicZoomPresentAnimationController.swift
//  Marvel Explorer
//
//  Created by Nathanael Gethers on 7/8/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit

class ComicZoomPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let containerView = transitionContext.containerView
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        let initFrame = originFrame
        let finalFrame = transitionContext.finalFrame(for: toVC!)
        
        let snapshot = toVC?.view.snapshotView(afterScreenUpdates: true)
        
        snapshot?.frame = initFrame
        
        containerView.addSubview((toVC?.view)!)
        containerView.addSubview(snapshot!)
        toVC?.view.isHidden = true
        
//        self.perspectiveTransformForContainerView(containerView)
        
//        snapshot.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2), 0.0, 1.0, 0.0)

//        Animation
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeCubic, animations: {
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
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3, animations: {
                snapshot?.frame = finalFrame
            })
        }) { _ in
            toVC?.view.isHidden = false
            snapshot?.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    func perspectiveTransformForContainerView(_ containerView: UIView) {
        var transform = CATransform3DIdentity
        transform.m34 = -0.002
        containerView.layer.sublayerTransform = transform
    }

}
