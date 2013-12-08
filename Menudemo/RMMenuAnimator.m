//
//  RMMenuAnimator.m
//  Menudemo
//
//  Created by Ronald Mannak on 12/7/13.
//  Copyright (c) 2013 Ronald Mannak. All rights reserved.
//

#import "RMMenuAnimator.h"

@implementation RMMenuAnimator

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    [[transitionContext containerView] addSubview:toViewController.view];
    
    CGRect offScreenRect, onScreenRect;
    offScreenRect = onScreenRect = [transitionContext initialFrameForViewController:fromViewController];
    offScreenRect.origin.x -= CGRectGetWidth(offScreenRect);
    onScreenRect.size.width /= 2.f;
    
    toViewController.view.frame = offScreenRect;
    toViewController.view.alpha = 0.5;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        toViewController.view.alpha = 1;
        toViewController.view.frame = onScreenRect;
        fromViewController.view.alpha = .3f;
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
}

@end
