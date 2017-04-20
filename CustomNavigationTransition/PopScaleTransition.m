//
//  PopScaleTransition.m
//  CustomNavigationTransition
//
//  Created by tomfriwel on 11/04/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "PopScaleTransition.h"
#import <AVFoundation/AVFoundation.h>

@implementation PopScaleTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *herbView = self.presenting ? toView : [transitionContext viewForKey:UITransitionContextFromViewKey];
    if (self.imageView) {
        herbView = self.imageView;
        [herbView setFrame:AVMakeRectWithAspectRatioInsideRect(self.imageView.image.size, self.imageView.frame)];
        
        [containerView addSubview:herbView];
    }
    
    CGRect initialFrame = self.presenting ? self.originFrame : herbView.frame;
    CGRect finalFrame = self.presenting ? herbView.frame : self.originFrame;
    
    CGFloat xScaleFactor = self.presenting ?
    initialFrame.size.width / finalFrame.size.width :
    finalFrame.size.width / initialFrame.size.width;
    
    CGFloat yScaleFactor = self.presenting ?
    initialFrame.size.height / finalFrame.size.height :
    finalFrame.size.height / initialFrame.size.height;
    
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor);
    
    if (self.presenting) {
        herbView.transform = scaleTransform;
        herbView.center = CGPointMake(CGRectGetMidX(initialFrame), CGRectGetMidY(initialFrame));
        herbView.clipsToBounds = YES;
    }
    
//    NSLog(@"herb:%@", NSStringFromCGRect(herbView.frame));
    
    [containerView addSubview:toView];
    [containerView bringSubviewToFront:herbView];
    
    if ([self.delegate respondsToSelector:@selector(animationWillBegin)]) {
        [self.delegate animationWillBegin];
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear animations:^{
        if (self.presenting) {
            herbView.transform = self.presenting ? CGAffineTransformIdentity : scaleTransform;
            herbView.center = CGPointMake(CGRectGetMidX(finalFrame), CGRectGetMidY(finalFrame));
        }
        else {
            herbView.center = CGPointMake(CGRectGetMidX(finalFrame), CGRectGetMidY(finalFrame));
            herbView.frame = self.originFrame;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        if ([self.delegate respondsToSelector:@selector(animationEnded)]) {
            [self.delegate animationEnded];
        }
    }];
}

@end
