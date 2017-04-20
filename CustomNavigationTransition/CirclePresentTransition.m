//
//  CirclePresentTransition.m
//  CustomNavigationTransition
//
//  Created by tomfriwel on 20/04/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "CirclePresentTransition.h"

@implementation CirclePresentTransition

#define ANIMATION_TIME 0.3
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return ANIMATION_TIME;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    // self.transitionContext = transitionContext;
    self.fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if (self.isPresenting) {
        [transitionContext.containerView addSubview:self.fromVC.view];
        [transitionContext.containerView addSubview:self.toVC.view];
        
        self.maskPath = [UIBezierPath bezierPathWithOvalInRect:self.senderFrame];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.toVC.view.frame;
        maskLayer.path = self.maskPath.CGPath;
        self.toVC.view.layer.mask = maskLayer;
        
        UIBezierPath *newPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-self.toVC.view.frame.size.width/2, -self.toVC.view.frame.size.height/2, self.toVC.view.frame.size.height*2, self.toVC.view.frame.size.height*2)];
        CABasicAnimation* pathAnim = [CABasicAnimation animationWithKeyPath: @"path"];
        //pathAnim.delegate = self;
        pathAnim.fromValue = (id)self.maskPath.CGPath;
        pathAnim.toValue = (id)newPath.CGPath;
        pathAnim.duration = ANIMATION_TIME;
        
//        pathAnim.speed = 2;
        
        maskLayer.path = newPath.CGPath;
        [maskLayer addAnimation:pathAnim forKey:@"path"];
    }else{
        [transitionContext.containerView addSubview:self.toVC.view];
        [transitionContext.containerView addSubview:self.fromVC.view];
        self.maskPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-self.fromVC.view.frame.size.width/2, -self.fromVC.view.frame.size.height/2, self.fromVC.view.frame.size.height*2, self.fromVC.view.frame.size.height*2)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.fromVC.view.frame;
        maskLayer.path = self.maskPath.CGPath;
        self.fromVC.view.layer.mask = maskLayer;
        
        UIBezierPath *newPath = [UIBezierPath bezierPathWithOvalInRect:self.senderFrame];
        CABasicAnimation* pathAnim = [CABasicAnimation animationWithKeyPath: @"path"];
        //pathAnim.delegate = self;
        pathAnim.fromValue = (id)self.maskPath.CGPath;
        pathAnim.toValue = (id)newPath.CGPath;
        pathAnim.duration = ANIMATION_TIME;
        
//        pathAnim.speed = 2;
        
        maskLayer.path = newPath.CGPath;
        [maskLayer addAnimation:pathAnim forKey:@"path"];
    }
    
    [self performSelector:@selector(finishTransition:) withObject:transitionContext afterDelay:ANIMATION_TIME];
}



-(void)finishTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    [transitionContext completeTransition:YES];
}


@end
