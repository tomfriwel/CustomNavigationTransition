//
//  PopScaleTransition.h
//  CustomNavigationTransition
//
//  Created by tomfriwel on 11/04/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopScaleTransitionDelegate <NSObject>

-(void)animationWillBegin;
-(void)animationEnded;

@end

@interface PopScaleTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, assign) BOOL presenting;
@property (nonatomic, strong) UIImageView *imageView;
@property (weak, nonatomic) id<PopScaleTransitionDelegate> delegate;

@end
