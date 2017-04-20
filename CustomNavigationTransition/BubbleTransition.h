//
//  BubbleTransition.h
//  CustomNavigationTransition
//
//  Created by tomfriwel on 20/04/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import <UIKit/UIKit.h>

//https://github.com/andreamazz/BubbleTransition

typedef NS_ENUM(NSInteger, BubbleTransitionMode) {
    present, dismiss, pop
};

@interface BubbleTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property CGPoint startingPoint;
@property BubbleTransitionMode transitionMode;
@property UIColor *bubbleColor;

@end
