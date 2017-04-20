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
#import "CirclePresentTransition.h"

#import "BubbleTransition.h"

@interface ViewController () <UIViewControllerTransitioningDelegate, ImageViewControllerDelegate, PopScaleTransitionDelegate>

@property (weak, nonatomic) IBOutlet UIButton *circleButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) PopScaleTransition *imageTransition;
@property (strong, nonatomic) CirclePresentTransition *circleTransition;
@property (strong, nonatomic) BubbleTransition *bubbleTransition;
@property (strong, nonatomic) NSString *presentType;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    [self.imageView addGestureRecognizer:tapGesture];
    self.presentType = @"none";
    self.circleButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.circleButton.layer.borderWidth  = 3;
    self.circleButton.layer.cornerRadius = self.circleButton.frame.size.height/2.0;
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
    self.presentType = @"popImage";
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)circlePresentAction:(UIButton *)sender {
    //CirclePresentedViewController
    
    
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CirclePresentedViewController"];
    vc.transitioningDelegate = self;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    self.presentType = @"popCircle";
    
//    self.circleTransition = [[CirclePresentTransition alloc] init];
//    self.circleTransition.senderFrame = [sender frame];
    self.bubbleTransition = [[BubbleTransition alloc] init];
    self.bubbleTransition.startingPoint = sender.center;
    self.bubbleTransition.bubbleColor = sender.backgroundColor ? sender.backgroundColor : [UIColor redColor];
    
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
    if ([self.presentType isEqualToString:@"popImage"]) {
        self.imageTransition.presenting = YES;
        return self.imageTransition;
    }
    if ([self.presentType isEqualToString:@"popCircle"]) {
//        self.circleTransition.isPresenting = YES;
//        return self.circleTransition;
        self.bubbleTransition.transitionMode = present;
        return self.bubbleTransition;
    }
    return nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if ([self.presentType isEqualToString:@"popImage"]) {
        self.imageTransition.presenting = NO;
        return self.imageTransition;
    }
    if ([self.presentType isEqualToString:@"popCircle"]) {
//        self.circleTransition.isPresenting = NO;
//        return self.circleTransition;
        self.bubbleTransition.transitionMode = dismiss;
        return self.bubbleTransition;
    }
    return nil;
}

@end
