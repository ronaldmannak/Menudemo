//
//  RMMenuAnimator.m
//  Menudemo
//
//  Created by Ronald Mannak on 12/7/13.
//  Copyright (c) 2013 Ronald Mannak. All rights reserved.
//

#import "RMMenuAnimator.h"

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

    CGRect offScreenRect, onScreenRect;
    
    offScreenRect = onScreenRect = [transitionContext initialFrameForViewController:fromViewController];
    offScreenRect.origin.x -= CGRectGetWidth(offScreenRect);
    onScreenRect.size.width = ceil(onScreenRect.size.width *0.66f);
    
    if (self.dismiss) {
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            toViewController.view.alpha = 1.f;
            fromViewController.view.frame = offScreenRect;
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
        
    } else {
        
        // We only need to add the toViewController's view to the containerView if we're presenting since
        // the presentingViewController is still on screen when the menu is dismissed
        [[transitionContext containerView] addSubview:toViewController.view];
        
        toViewController.view.frame = offScreenRect;
        toViewController.view.alpha = .1f;
        fromViewController.view.alpha = .75f;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            toViewController.view.alpha = 1.f;
            toViewController.view.frame = onScreenRect;
            fromViewController.view.alpha = .3f;
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
    }
}

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
}

@end
