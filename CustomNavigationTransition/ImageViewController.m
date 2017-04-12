//
//  ImageViewController.m
//  CustomNavigationTransition
//
//  Created by tomfriwel on 12/04/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageView.image = self.image;
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    [self.imageView addGestureRecognizer:tapGesture];
}

-(void)dismiss:(id)sender {
    if ([self.delegate respondsToSelector:@selector(viewControllerWillDismissWithView:)]) {
        [self.delegate viewControllerWillDismissWithView:self.imageView];
    }
//    self.imageTransition.imageView = self.imageView;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
