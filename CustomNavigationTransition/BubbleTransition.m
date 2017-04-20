//
//  BubbleTransition.m
//  CustomNavigationTransition
//
//  Created by tomfriwel on 20/04/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "BubbleTransition.h"

@interface BubbleTransition()

@end


@implementation BubbleTransition

-(instancetype)init {
    self = [super init];
    
    self.startingPoint = CGPointZero;
    self.dureation = 0.5;
    self.transitionMode = present;
    self.bubbleColor = [UIColor whiteColor];
    self.bubble = [[UIView alloc] init];
    
    return self;
}

//-(UIColor *)bubbleColor {
//    if (!_bubbleColor) {
//        _bubbleColor = [UIColor whiteColor];
//    }
//    return _bubbleColor;
//}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.dureation;
}


-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;
    
    if (self.transitionMode == present) {
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        CGPoint originalCenter = toView.center;
        CGSize originalSize = toView.frame.size;
        
        self.bubble = [[UIView alloc] init];
        self.bubble.frame = [self frameForBubble:originalCenter originalSize:originalSize start:self.startingPoint];
        self.bubble.layer.cornerRadius = self.bubble.frame.size.height / 2;
        self.bubble.center = self.startingPoint;
        self.bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
        self.bubble.backgroundColor = [UIColor colorWithRed:0.15 green:0.70 blue:0.80 alpha:1.00];
        [containerView addSubview:self.bubble];
        
        toView.center = self.startingPoint;
        toView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        toView.alpha = 0;
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:self.dureation delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear  animations:^{
            
            self.bubble.transform = CGAffineTransformIdentity;
            toView.transform = CGAffineTransformIdentity;
            toView.alpha = 1;
            toView.center = originalCenter;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        NSString *key = UITransitionContextFromViewKey;//(self.transitionMode == pop) ? UITransitionContextToViewKey : UITransitionContextFromViewKey;
        UIView *toView = [transitionContext viewForKey:key];
        CGPoint originalCenter = toView.center;
        CGSize originalSize = toView.frame.size;
        
        self.bubble.frame = [self frameForBubble:originalCenter originalSize:originalSize start:self.startingPoint];
        self.bubble.layer.cornerRadius = self.bubble.frame.size.height / 2;
        self.bubble.center = self.startingPoint;
        
//        [containerView addSubview:toView];
//        [containerView bringSubviewToFront:self.bubble];
        //        self.bubble.backgroundColor = [UIColor redColor];
        
        [UIView animateWithDuration:self.dureation delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear  animations:^{
            self.bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
            toView.transform = CGAffineTransformMakeScale(0.001, 0.001);
            toView.center = self.startingPoint;
            toView.alpha = 0;
        } completion:^(BOOL finished) {
            toView.center = originalCenter;
            [toView removeFromSuperview];
            [self.bubble removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
        
    }
}
//
//-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
//    UIView *containerView = transitionContext.containerView;
//
//    if (self.transitionMode == present) {
//        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
//        CGPoint originalCenter = toView.center;
//        CGSize originalSize = toView.frame.size;
//        
//        self.bubble = toView;
//        self.bubble.frame = [self frameForBubble:originalCenter originalSize:originalSize start:self.startingPoint];
//        
//        self.bubble.layer.cornerRadius = self.bubble.frame.size.height / 2;
//        self.bubble.center = self.startingPoint;
//        self.bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
//        
////        self.bubble.backgroundColor = [UIColor redColor];
//        [containerView addSubview:self.bubble];
//        
////        presentedControllerView.center = self.startingPoint;
////        presentedControllerView.transform = CGAffineTransformMakeScale(0.001, 0.001);
//        toView.alpha = 0;
//        [containerView addSubview:self.bubble];
//        
//        [UIView animateWithDuration:self.dureation delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear  animations:^{
//            self.bubble.transform = CGAffineTransformIdentity;
////            self.bubble.layer.cornerRadius = 0;
//            self.bubble.alpha = 1;
//            self.bubble.center = originalCenter;
////            presentedControllerView.transform = CGAffineTransformIdentity;
//        } completion:^(BOOL finished) {
//            [transitionContext completeTransition:YES];
//        }];
//    } else {
//        NSString *key = UITransitionContextToViewKey;//(self.transitionMode == pop) ? UITransitionContextToViewKey : UITransitionContextFromViewKey;
//        UIView *toView = [transitionContext viewForKey:key];
//        CGPoint originalCenter = toView.center;
//        CGSize originalSize = toView.frame.size;
//        
//        self.bubble.frame = [self frameForBubble:originalCenter originalSize:originalSize start:self.startingPoint];
//        self.bubble.layer.cornerRadius = self.bubble.frame.size.height / 2;
//        self.bubble.center = self.startingPoint;
//        
//        [containerView addSubview:toView];
//        [containerView bringSubviewToFront:self.bubble];
////        self.bubble.backgroundColor = [UIColor redColor];
//        
//        [UIView animateWithDuration:self.dureation delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear  animations:^{
//            self.bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
////            returningControllerView.transform = CGAffineTransformMakeScale(0.001, 0.001);
////            returningControllerView.center = self.startingPoint;
////            returningControllerView.alpha = 0;
//            
////            if (self.transitionMode == pop) {
////                [containerView insertSubview:returningControllerView belowSubview:returningControllerView];
////                [containerView insertSubview:self.bubble belowSubview:returningControllerView];
////            }
//        } completion:^(BOOL finished) {
////            returningControllerView.center = originalCenter;
////            [returningControllerView removeFromSuperview];
////            [self.bubble removeFromSuperview];
//            [transitionContext completeTransition:YES];
//        }];
//        
//    }
//}

-(CGRect)frameForBubble:(CGPoint)originalCenter originalSize:(CGSize)originalSize start:(CGPoint)start {
    CGFloat lengthX = fmax(start.x, originalSize.width - start.x);
    CGFloat lengthY = fmax(start.y, originalSize.height - start.y);
    CGFloat offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2;
//    CGSize size = CGSizeMake(offset, offset);
    
    return CGRectMake(0, 0, offset, offset);
}

@end
