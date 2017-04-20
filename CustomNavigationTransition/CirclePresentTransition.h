//
//  CirclePresentTransition.h
//  CustomNavigationTransition
//
//  Created by tomfriwel on 20/04/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CirclePresentTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (strong,nonatomic) UIBezierPath *maskPath;
@property (strong,nonatomic) UIViewController *toVC;
@property (strong,nonatomic) UIViewController *fromVC;


@property (nonatomic) BOOL isPresenting;
@property (nonatomic) CGRect senderFrame;

@end
