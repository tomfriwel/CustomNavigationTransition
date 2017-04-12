//
//  ImageViewController.h
//  CustomNavigationTransition
//
//  Created by tomfriwel on 12/04/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageViewControllerDelegate <NSObject>

-(void)viewControllerWillDismissWithView:(UIImageView *)view;

@end

@interface ImageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) id<ImageViewControllerDelegate> delegate;

@property (strong, nonatomic) UIImage *image;

@end
