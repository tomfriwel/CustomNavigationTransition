//
//  CustomNavigationAnimationController.m
//  TestAnimator
//
//  Created by tomfriwel on 29/12/2016.
//  Copyright © 2016 tomfriwel. All rights reserved.
//

#import "CustomNavigationAnimationController.h"

@implementation CustomNavigationAnimationController

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *toView = toViewController.view;
    UIView *fromView = fromViewController.view;
    CGFloat direction = self.reverse ? -1 : 1;
    
    CATransform3D viewFromTransform = CATransform3DMakeTranslation(0, 0, 0);
    CATransform3D viewToTransform = CATransform3DMakeTranslation(0, direction * containerView.frame.size.height, 0);

    
    containerView.transform = CGAffineTransformMakeTranslation(0, 0);
    
    toView.layer.transform = viewToTransform;
    [containerView addSubview: toView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        containerView.transform = CGAffineTransformMakeTranslation(0, -direction * containerView.frame.size.height);
        fromView.layer.transform = viewFromTransform;
        toView.layer.transform = CATransform3DMakeTranslation(0, direction * containerView.frame.size.height, 0);
    } completion:^(BOOL finished) {
        containerView.transform =  CGAffineTransformIdentity;
        fromView.layer.transform = CATransform3DIdentity;
        toView.layer.transform = CATransform3DIdentity;
        
        if (transitionContext.transitionWasCancelled) {
            [toView removeFromSuperview];
        } else {
            [fromView removeFromSuperview];
        }
        [transitionContext completeTransition: ![transitionContext transitionWasCancelled]];
    }];
}

@end
