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

@property (nonatomic, strong) RMMenuAnimator *animator;

@end

@implementation RMMenuDelegate

- (id)init
{
    self = [super init];
    if (self) {
        self.animator = [[RMMenuAnimator alloc] init];
    }
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    self.animator.dismiss = NO;
    return self.animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.animator.dismiss = YES;
    return self.animator;
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
