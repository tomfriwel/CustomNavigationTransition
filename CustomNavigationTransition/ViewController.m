//
//  ViewController.m
//  CustomNavigationTransition
//
//  Created by tomfriwel on 11/04/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "ViewController.h"

#import "CustomInteractionController.h"
#import "CustomNavigationAnimationController.h"
#import "SecondViewController.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate, UINavigationControllerDelegate, CustomInteractionControllerDelegate>

@property CustomInteractionController *interaction;
@property CustomNavigationAnimationController *navAnimation;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property BOOL transitionInProgress;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interaction = [[CustomInteractionController alloc] init];
    self.interaction.interactionDelegate = self;
    
    self.navAnimation = [[CustomNavigationAnimationController alloc] init];
    self.navigationController.delegate = self;
    [self.interaction attachToViewController:self forEdge:UIRectEdgeRight];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - CustomInteractionControllerDelegate

-(void)beginInteractionForEdge:(UIRectEdge)edge {
    switch (edge) {
        case UIRectEdgeRight:{
            break;
        }
        case UIRectEdgeLeft:{
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
            
            
        default:
            break;
    }
}

-(void)endInteraction {
    
}

#pragma mark - UIViewControllerTransitioningDelegate

#pragma mark - UINavigationControllerDelegate

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        [self.interaction attachToViewController:toVC forEdge:UIRectEdgeLeft];
    }
    self.navAnimation.reverse = operation == UINavigationControllerOperationPop;
    return self.navAnimation;
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.interaction.transitionInProgress ? self.interaction : nil;
}


@end
