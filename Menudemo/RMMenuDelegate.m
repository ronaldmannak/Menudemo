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

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
           animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                             toViewController:(UIViewController *)toVC
{
    return [[RMMenuAnimator alloc] init];
}

@end
