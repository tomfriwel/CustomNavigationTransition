//
//  PopScaleTransition.m
//  CustomNavigationTransition
//
//  Created by tomfriwel on 11/04/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "PopScaleTransition.h"

@implementation PopScaleTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    
    UIView *toView = toViewController.view;
    
    UIView *scaleView = self.presenting ? toView : fromViewController.view;
//    UIView *fromView = fromViewController.view;
    
    CGFloat direction = self.presenting ? -1 : 1;
    
    CGRect initialFrame = self.presenting ? self.originFrame : scaleView.frame;
    CGRect finalFrame = self.presenting ? scaleView.frame : self.originFrame;
    
//    CATransform3D viewFromTransform = CATransform3DMakeTranslation(0, 0, 0);
//    CATransform3D viewToTransform = CATransform3DMakeTranslation(0, direction * containerView.frame.size.height, 0);
//    
//    
//    containerView.transform = CGAffineTransformMakeTranslation(0, 0);
    
    toView.frame = initialFrame;
    
    
//    toView.layer.transform = viewToTransform;
    [containerView addSubview: toView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = finalFrame;
    } completion:^(BOOL finished) {
        
        if (transitionContext.transitionWasCancelled) {
            [toView removeFromSuperview];
        } else {
//            [fromView removeFromSuperview];
        }
        [transitionContext completeTransition: ![transitionContext transitionWasCancelled]];
    }];
}

@end
