//
//  RMMenuAnimator.m
//  Menudemo
//
//  Created by Ronald Mannak on 12/7/13.
//  Copyright (c) 2013 Ronald Mannak. All rights reserved.
//

#import "RMMenuAnimator.h"
#import "UIImage+ImageEffects.h"
#import "UIView+Screenshot.h"

static const NSInteger kBlurImageTag = 9999;
static const NSInteger kDarkenViewTag = 9998;

@interface RMMenuAnimator ()

@end

@implementation RMMenuAnimator

- (id)init
{
    self = [super init];
    if (self) {
        self.duration = .2f;
    }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    NSAssert(![fromViewController.view viewWithTag:kBlurImageTag], @"Can't have another view with tag kBlurImageTag (9999)");
    NSAssert(![fromViewController.view viewWithTag:kDarkenViewTag], @"Can't have another view with tag kDarkenViewTag (9998)");

    CGRect offScreenRect, onScreenRect;
    offScreenRect = onScreenRect = [transitionContext initialFrameForViewController:fromViewController];
    offScreenRect.origin.x -= CGRectGetWidth(offScreenRect);
    onScreenRect.size.width = ceil(onScreenRect.size.width *0.66f);
    
    if (self.dismiss) {
        
        UIView *blurImageView = [toViewController.view viewWithTag:kBlurImageTag];
        CGRect blurFrame = onScreenRect;
        blurFrame.size.width = 0.f;
        
        UIView *darkenView = [toViewController.view viewWithTag:kDarkenViewTag];
        
        NSAssert(blurImageView && [blurImageView isKindOfClass:[UIImageView class]], @"blurImageView not found");
        NSAssert(darkenView && [darkenView isKindOfClass:[UIView class]], @"darkenView not found");
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
            fromViewController.view.frame = offScreenRect;
            blurImageView.frame = blurFrame;
            
            darkenView.frame = toViewController.view.bounds;
            darkenView.alpha = 0.f;
            
        } completion:^(BOOL finished) {
            
            [blurImageView removeFromSuperview];
            [darkenView removeFromSuperview];
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];

        }];
        
    } else {
        
        // We only need to add the toViewController's view to the containerView if we're presenting since
        // the presentingViewController is still on screen when the menu is dismissed
        [[transitionContext containerView] addSubview:toViewController.view];
        
        toViewController.view.frame = offScreenRect;
        
        // Create blurred view of fromViewController
        UIImage *fromScreenshot = [fromViewController.view screenshot];
        UIImage *blurImage = [fromScreenshot applyLightEffect];
        UIImageView *blurImageView = (UIImageView *) ((UITableViewController *)toViewController).tableView.backgroundView;
        blurImageView.image = blurImage;
        blurImageView = [[UIImageView alloc] initWithImage:blurImage];
        blurImageView.clipsToBounds = YES;
        CGRect blurImageRect = fromViewController.view.bounds;
        blurImageRect.size.width = 0.f;
        blurImageView.frame = blurImageRect;
        blurImageView.tag = kBlurImageTag;
        blurImageView.contentMode = UIViewContentModeLeft;
        [fromViewController.view addSubview:blurImageView];
        
        // create darken view on to of presenting viewcontroller
        UIView *darkenView = [[UIView alloc] initWithFrame:fromViewController.view.bounds];
        darkenView.backgroundColor = [UIColor blackColor];
        darkenView.alpha = .0f;
        darkenView.tag = kDarkenViewTag;
        [fromViewController.view addSubview:darkenView];
        CGRect darkenFrame = darkenView.frame;
        darkenFrame.origin.x = onScreenRect.size.width;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            toViewController.view.frame = blurImageView.frame = onScreenRect;
            
            darkenView.frame = darkenFrame;
            darkenView.alpha = .5f;
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
    }
}

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
}

@end
