//
//  ViewController.m
//  CustomNavigationTransition
//
//  Created by tomfriwel on 11/04/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "ViewController.h"

#import "PopScaleTransition.h"
#import "ImageViewController.h"

@interface ViewController () <UIViewControllerTransitioningDelegate, ImageViewControllerDelegate, PopScaleTransitionDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) PopScaleTransition *imageTransition;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    [self.imageView addGestureRecognizer:tapGesture];
}

-(void)tapHandle:(UITapGestureRecognizer *)sender {
    NSLog(@"Tap image");
    
    ImageViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ImageViewController"];
    vc.image = [(UIImageView *)sender.view image];
    vc.delegate = self;
    vc.transitioningDelegate = self;
    
    self.imageTransition = [[PopScaleTransition alloc] init];
    self.imageTransition.delegate = self;
    self.imageTransition.originFrame = [(UIImageView *)sender.view frame];
    
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - ImageViewControllerDelegate
-(void)viewControllerWillDismissWithView:(UIImageView *)view {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:view.frame];
    imageView.image = view.image;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
//    NSLog(@"image:%@", NSStringFromCGRect(imageView.frame));
    self.imageTransition.imageView = imageView;
}

#pragma mark - PopScaleTransitionDelegate

-(void)animationWillBegin {
    [self.imageView setHidden:YES];
}

-(void)animationEnded {
    [self.imageView setHidden:NO];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.imageTransition.presenting = YES;
    return self.imageTransition;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.imageTransition.presenting = NO;
    return self.imageTransition;
}

@end
