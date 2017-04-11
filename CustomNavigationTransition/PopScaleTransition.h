//
//  PopScaleTransition.h
//  CustomNavigationTransition
//
//  Created by tomfriwel on 11/04/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopScaleTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, assign) BOOL presenting;

@end
