//
//  RMMenuDelegate.m
//  Menudemo
//
//  Created by Ronald Mannak on 12/7/13.
//  Copyright (c) 2013 Ronald Mannak. All rights reserved.
//

#import "RMMenuDelegate.h"
#import "RMMenuAnimator.h"

@interface RMMenuDelegate ()

@end

@implementation RMMenuDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [[RMMenuAnimator alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    RMMenuAnimator *animator = [[RMMenuAnimator alloc] init];
    animator.dismiss = YES;
    return animator;
}


/*
 - (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
 interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
 {
 return nil;// self.interactionController;
 }
 
 - (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
 {
 return  nil;
 }
 */

@end
