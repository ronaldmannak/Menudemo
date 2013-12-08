//
//  RMTabBarAnimator.m
//  Menudemo
//
//  Created by Ronald Mannak on 12/7/13.
//  Copyright (c) 2013 Ronald Mannak. All rights reserved.
//

#import "RMTabBarAnimator.h"

@implementation RMTabBarAnimator

- (id)init
{
    self = [super init];
    if (self) {
        self.duration = .3f;
    }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    [[transitionContext containerView] addSubview:toViewController.view];
    
    CGRect offScreenRect = [transitionContext initialFrameForViewController:fromViewController];
    offScreenRect.origin.x += CGRectGetWidth(offScreenRect);
    toViewController.view.frame = offScreenRect;
    
    // animating fromView.view.alpha to 0 doesn't animate well. The navigationbar will flicker.
    // Adding a temp view to darken fromViewController
    
    UIView *darkView = [[UIView alloc] initWithFrame:fromViewController.view.bounds];
    darkView.backgroundColor = [UIColor blackColor];
    darkView.alpha = 0.f;
    [fromViewController.view addSubview:darkView];
    
    [UIView animateWithDuration:self.duration
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            fromViewController.view.transform = CGAffineTransformMakeScale(0.8, 0.8);
                            darkView.alpha = .5f;
                            
                            toViewController.view.frame = [transitionContext initialFrameForViewController:fromViewController];
                            
                        } completion:^(BOOL finished) {
                            
                            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                            
                            fromViewController.view.transform = CGAffineTransformIdentity;
                            [darkView removeFromSuperview];

                        }];
}

@end
