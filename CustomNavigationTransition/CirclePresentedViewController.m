//
//  CirclePresentedViewController.m
//  CustomNavigationTransition
//
//  Created by tomfriwel on 20/04/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "CirclePresentedViewController.h"

@interface CirclePresentedViewController ()

@end

@implementation CirclePresentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
    
//    CGRect myRect = CGRectMake(100, 100, 100, 100);
//    int radius = myRect.size.width;
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) cornerRadius:0];
//    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius) cornerRadius:radius];
//    [path appendPath:circlePath];
//    [path setUsesEvenOddFillRule:YES];
//    
//    CAShapeLayer *fillLayer = [CAShapeLayer layer];
//    fillLayer.path = path.CGPath;
//    fillLayer.fillRule = kCAFillRuleEvenOdd;
//    fillLayer.fillColor = [UIColor grayColor].CGColor;
//    fillLayer.opacity = 0.5;
//    [self.view.layer addSublayer:fillLayer];
}

-(void)handleTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
