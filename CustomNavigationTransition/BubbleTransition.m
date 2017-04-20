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
        UIView *presentedControllerView = [transitionContext viewForKey:UITransitionContextToViewKey];
        CGPoint originalCenter = presentedControllerView.center;
        CGSize originalSize = presentedControllerView.frame.size;
        
        self.bubble = presentedControllerView;
        self.bubble.frame = [self frameForBubble:originalCenter originalSize:originalSize start:self.startingPoint];
        
        self.bubble.layer.cornerRadius = self.bubble.frame.size.height / 2;
        self.bubble.center = self.startingPoint;
        self.bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
        
//        self.bubble.backgroundColor = self.bubbleColor;
        [containerView addSubview:self.bubble];
        
        presentedControllerView.center = self.startingPoint;
        presentedControllerView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        presentedControllerView.alpha = 0;
        [containerView addSubview:presentedControllerView];
        
        [UIView animateWithDuration:self.dureation animations:^{
            self.bubble.transform = CGAffineTransformIdentity;
            presentedControllerView.alpha = 1;
            presentedControllerView.center = originalCenter;
            presentedControllerView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        NSString *key = UITransitionContextToViewKey;//(self.transitionMode == pop) ? UITransitionContextToViewKey : UITransitionContextFromViewKey;
        UIView *returningControllerView = [transitionContext viewForKey:key];
        CGPoint originalCenter = returningControllerView.center;
        CGSize originalSize = returningControllerView.frame.size;
        
        self.bubble.frame = [self frameForBubble:originalCenter originalSize:originalSize start:self.startingPoint];
        self.bubble.layer.cornerRadius = self.bubble.frame.size.height / 2;
        self.bubble.center = self.startingPoint;
        
        [containerView addSubview:returningControllerView];
        [containerView bringSubviewToFront:self.bubble];
//        self.bubble.backgroundColor = [UIColor redColor];
        
        [UIView animateWithDuration:self.dureation animations:^{
            self.bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
//            returningControllerView.transform = CGAffineTransformMakeScale(0.001, 0.001);
//            returningControllerView.center = self.startingPoint;
//            returningControllerView.alpha = 0;
            
//            if (self.transitionMode == pop) {
//                [containerView insertSubview:returningControllerView belowSubview:returningControllerView];
//                [containerView insertSubview:self.bubble belowSubview:returningControllerView];
//            }
        } completion:^(BOOL finished) {
//            returningControllerView.center = originalCenter;
//            [returningControllerView removeFromSuperview];
//            [self.bubble removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
        
    }
}

-(CGRect)frameForBubble:(CGPoint)originalCenter originalSize:(CGSize)originalSize start:(CGPoint)start {
    CGFloat lengthX = fmax(start.x, originalSize.width - start.x);
    CGFloat lengthY = fmax(start.y, originalSize.height - start.y);
    CGFloat offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2;
//    CGSize size = CGSizeMake(offset, offset);
    
    return CGRectMake(0, 0, offset, offset);
}

@end
